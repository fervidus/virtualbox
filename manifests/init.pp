# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include virtualbox
class virtualbox {
  include ::virtualbox::pre_install
  include ::virtualbox::install

  Class['::virtualbox::pre_install']
  -> Class['::virtualbox::install']
}
