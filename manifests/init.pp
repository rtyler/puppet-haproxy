
class haproxy {
  include concat::setup

  package {
    'haproxy' :
      ensure => present;
  }
}
