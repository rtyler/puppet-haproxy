
class haproxy {
  include concat::setup

  package {
    'haproxy' :
      ensure => present;
  }

  service {
    'haproxy' :
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      ensure     => running;
  }

  file {
    '/etc/default/haproxy' :
      ensure => present,
      owner  => 'root',
      group  => 'root',
      source => 'puppet:///modules/haproxy/haproxy.default.etc';
  }
}
