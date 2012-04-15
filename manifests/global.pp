define haproxy::global(
  $debug_mode=false,
  $quiet_mode=false,
  $chroot='undefined',
  $daemonize=false,
  $gid='undefined',
  $group='undefined'
) {
  include haproxy
  include concat::setup

  concat::fragment {
    'haproxy global block' :
      target  => $haproxy::config_file,
      content => "global\n",
      order   => 1;
  }

  ############################
  # GNARLY PARAMETER HANDLING MESS, PROCEED NO FURTHER
  ############################
  if ($debug_mode) {
    concat::fragment {
      'enable debugging' :
        target  => $haproxy::config_file,
        order   => 2,
        content => "\tdebug\n";
    }
  }
  if ($quiet_mode) {
    concat::fragment {
      'enable quiet mode' :
        target  => $haproxy::config_file,
        order   => 2,
        content => "\tquiet\n";
    }
  }
  if ($chroot != 'undefined') {
    concat::fragment {
      "chroot to ${chroot}" :
        target  => $haproxy::config_file,
        order   => 2,
        content => "\tchroot ${chroot}\n";
    }
    if (!defined(File[$chroot])) {
      file {
        $chroot :
          ensure => directory,
          mode   => 755;
      }
    }
  }
  if ($daemonize) {
    concat::fragment {
      'daemonize' :
        target  => $haproxy::config_file,
        order   => 2,
        content => "\tdaemon\n";
    }
  }
  if ($gid != 'undefined') {
    concat::fragment {
      "gid ${gid}" :
        target  => $haproxy::config_file,
        order   => 2,
        content => "\tgid ${gid}\n";
    }
    if (!defined(Group[$gid])) {
      group {
        $gid :
          ensure => present,
          gid    => $gid;
      }
    }
  }
  if ($group != 'undefined') {
    concat::fragment {
      "group ${group}" :
        target  => $haproxy::config_file,
        order   => 2,
        content => "\tgroup ${group}\n";
    }
    if (!defined(Group[$group])) {
      group {
        $group :
          ensure => present;
      }
    }
  }
}
