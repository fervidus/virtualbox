# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include virtualbox::install
class virtualbox::install {
  package { 'VirtualBox-6.1':
    ensure => 'installed'
  }
}
