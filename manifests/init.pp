class rsyslog {
    
    $rsyslogPackage = $operatingsystem ? {
            default => "rsyslog"
        }
    $rsyslogServer = "sps-nms:514"
    
}

class rsyslog::base inherits rsyslog {
    
    package { $rsyslogPackage:
        ensure => installed
    }
    
    file { 
        "/etc/rsyslog.conf":
        mode => "644",
        owner => root,
        group => root,
        content => template("rsyslog/rsyslog_conf.erb"),
        notify => Service["rsyslog"],
        require => Package[$rsyslogPackage];
        
        "/etc/rsyslog.d":
        ensure => directory,
        mode => 0755,
        owner => root,
        group => root,
        require => Package[$rsyslogPackage];
        
        "/etc/rsyslog.d/50-default.conf":
        mode => "644",
        owner => root,
        group => root,
        content => template("rsyslog/50-default_conf.erb"),
        notify => Service["rsyslog"],
        require => Package[$rsyslogPackage];
         
    }

    service { "rsyslog": 
        ensure => running,
        enable => true,
        require => Package[$rsyslogPackage];
    }

}

class rsyslog::server inherits rsyslog::base {
    
    file { 
        "/etc/rsyslog.d/5-server.conf":
        mode => "644",
        content => template("rsyslog/5-server_conf.erb"),
        notify => Service["rsyslog"],
        require => Package[$rsyslogPackage];
        
        "/etc/rsyslog.d/10-forward.conf":
        ensure => absent;
    }
}

class rsyslog::client inherits rsyslog::base {
    
    file { 
        "/etc/rsyslog.d/10-forward.conf":
        mode => "644",
        content => template("rsyslog/10-forward_conf.erb"),
        notify => Service["rsyslog"],
        require => Package[$rsyslogPackage];
        
        "/etc/rsyslog.d/5-server.conf":
        ensure => absent;
    }
}
