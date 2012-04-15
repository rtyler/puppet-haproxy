
class haproxy {
  include concat::setup
  $config_file = '/etc/haproxy/haproxy.cfg'

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

  concat {
    $config_file :
      owner => 'root',
      group => 'root',
      mode  => 644;
  }
}
