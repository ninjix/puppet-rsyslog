class rsyslog {
  $rsyslogPackage = $operatingsystem ? {
    default => "rsyslog"
  }
  $rsyslogServer = "myserver:514"

}

