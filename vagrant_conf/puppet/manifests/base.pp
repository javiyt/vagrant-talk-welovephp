Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

group { 'puppet':
    ensure => present,
}

import "system.pp"
import "web.pp"
import "php55.pp"

include system-update

class { "php55": require => Class["web"] }
class { "web": }