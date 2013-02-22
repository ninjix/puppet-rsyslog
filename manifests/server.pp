class rsyslog::server inherits rsyslog::base {
  file {
    "/etc/rsyslog.d/5-server.conf":
      mode    => "644",
      content => template("rsyslog/5-server_conf.erb"),
      notify  => Service["rsyslog"],
      require => Package[$rsyslogPackage];

    "/etc/rsyslog.d/10-forward.conf":
      ensure => absent;
  }
}
