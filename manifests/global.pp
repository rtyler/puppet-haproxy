define haproxy::global() {
  # NOTE: I feel like this include should be unnecessary, but currently is
  # because we cannot set the :pre_condition properly inside of rspec-puppet
  include haproxy
  include concat::setup

  concat::fragment {
    'haproxy global block' :
      target  => $haproxy::config_file,
      content => "global\n",
      order   => 1;
  }
}
