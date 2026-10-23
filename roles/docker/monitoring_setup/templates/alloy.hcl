// Prometheus metric collection configuration

// Node Exporter setup: collects hardware and OS-level metrics
prometheus.exporter.unix "default" {}

// Relabeling rules to map unix exporter targets to the specific Ansible inventory hostname
discovery.relabel "unix" {
    targets=prometheus.exporter.unix.default.targets

    rule {
        target_label = "nodename"
        replacement = "{{ inventory_hostname }}"
    }
}

// Scrape job for Node Exporter metrics, forwarding to Mimir
prometheus.scrape "unix" {
    targets=discovery.relabel.unix.output

    forward_to = [prometheus.remote_write.mimir.receiver]
}

// Scrape job for cAdvisor metrics (container-level metrics), forwarding to Mimir
prometheus.scrape "cadvisor" {
    targets = [{
        "__address__" = "cadvisor:8080",
        "instance" = "{{ inventory_hostname }}",
    }]

    forward_to = [prometheus.remote_write.mimir.receiver]
}

// eBPF profiling collection
pyroscope.ebpf "default" {
  forward_to = [pyroscope.write.pyroscope.receiver]
}

// Loki log collection configuration

// Docker log collection via the Docker socket
discovery.docker "containers" {
  host = "unix:///var/run/docker.sock"
}

loki.source.docker "containers" {
  host       = "unix:///var/run/docker.sock"
  targets    = discovery.docker.containers.targets
  labels = {
    nodename = "{{ inventory_hostname }}",
    job      = "docker",
  }
  forward_to = [loki.write.loki.receiver]
}

// Systemd journal log collection
loki.source.journal "default" {
  path   = "/var/log/journal"
  labels = {
    nodename = "{{ inventory_hostname }}",
    job      = "journal",
  }

  forward_to = [loki.write.loki.receiver]
}


// Remote write/push configurations (Exporters)

// Configuration to push profiling data to Grafana Pyroscope
pyroscope.write "pyroscope" {
  endpoint {
    url = "http://{{ hostvars['grafana'].ansible_host }}:4040"
  }
}

// Configuration to push Prometheus metrics to Grafana Mimir
prometheus.remote_write "mimir" {
  endpoint {
    url = "http://{{ hostvars['grafana'].ansible_host }}:9009/api/v1/push"
  }
}

// Configuration to push Loki logs to Grafana Loki
loki.write "loki" {
  endpoint {
    url = "http://{{ hostvars['grafana'].ansible_host }}:3100/loki/api/v1/push"
  }
}
