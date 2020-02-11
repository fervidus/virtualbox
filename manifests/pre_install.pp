# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include virtualbox::pre_install
class virtualbox::pre_install {
  $required_packages = ['gcc', "kernel-devel-${facts['kernelrelease']}", 'kernel-headers', 'dkms', 'make', 'patch']

  package { $required_packages:
    ensure => installed,
  }

  case $facts['os']['name'] {
    'RedHat', 'CentOS', 'OracleLinux' : {
      yumrepo { 'virtualbox':
        descr         => 'Oracle Linux / RHEL / CentOS-$releasever / $basearch - VirtualBox',
        baseurl       => 'http://download.virtualbox.org/virtualbox/rpm/el/$releasever/$basearch',
        enabled       => 1,
        gpgcheck      => 1,
        repo_gpgcheck => 1,
        gpgkey        => 'https://www.virtualbox.org/download/oracle_vbox.asc',
      }
    }

    'Fedora': {
      yumrepo { 'virtualbox':
        descr         => 'Fedora $releasever - $basearch - VirtualBox',
        baseurl       => 'http://download.virtualbox.org/virtualbox/rpm/fedora/$releasever/$basearch',
        enabled       => 1,
        gpgcheck      => 1,
        repo_gpgcheck => 1,
        gpgkey        => 'https://www.virtualbox.org/download/oracle_vbox.asc',
      }
    }

    'SLES': {
      yumrepo { 'virtualbox':
        descr        => 'VirtualBox for openSUSE $releasever - $basearch',
        baseurl      => 'http://download.virtualbox.org/virtualbox/rpm/opensuse/$releasever/$basearch',
        enabled      => 1,
        priority     => 120,
        gpgcheck     => 1,
        gpgkey       => 'https://www.virtualbox.org/download/oracle_vbox.asc',
      }
    }

    'Debian', 'Ubuntu': {
      file_line { 'repo_line':
        ensure => present,
        path   => '/etc/apt/sources.list',
        line   => "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian ${facts['lsbdistcodename']} contrib",
      }
    }
  }
}
