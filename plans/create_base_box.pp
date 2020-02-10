plan virtualbox::create_base_box(
    TargetSpec $nodes,
) {
  apply_prep($nodes)

  apply($nodes) {
    include ::epel

    file { '/home/vagrant/.ssh':
      ensure => directory,
      mode   => '0700',
    }

    file { '/home/vagrant/.ssh/authorized_keys':
      ensure => 'file',
      mode   => '0600',
    }

    file_line { 'vagrant_key':
      path => '/home/vagrant/.ssh/authorized_keys',
      line => 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key',
    }

    file_line { 'vagrant_sudo_rule':
      path => '/etc/sudoers',
      line => 'vagrant ALL=(ALL) NOPASSWD: ALL',
    }

    $required_packages = ['wget', 'gcc', "kernel-devel-${facts['kernelrelease']}", 'kernel-headers', 'dkms', 'make', 'bzip2', 'perl']

    package { $required_packages:
      ensure => installed,
    }
  }

  $vbox_version = $facts['hypervisors']['virtualbox']['version']

  run_task('virtualbox::add_virtualbox_additions', $nodes, vbox_version => $vbox_version)
}
