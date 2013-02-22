class rsyslog::client inherits rsyslog::base {
  file {
    "/etc/rsyslog.d/10-forward.conf":
      mode    => "644",
      content => template("rsyslog/10-forward_conf.erb"),
      notify  => Service["rsyslog"],
      require => Package[$rsyslogPackage];

    "/etc/rsyslog.d/5-server.conf":
      ensure => absent;
  }
}
