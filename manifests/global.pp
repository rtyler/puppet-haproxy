define haproxy::global(
  $debug_mode=false
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
}
