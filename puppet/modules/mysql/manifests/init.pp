class mysql {
include aptitude
##Below property is now being set in an env var.
$mysqlPassword = '$(cat /vagrant/password.txt)'

#$(cat /var/secure/password.txt)
  package { "mysql-client" :
    ensure  =>  "present",
    require => Class[ "aptitude" ],
    }
  package { "mysql-server" :
    ensure  =>  "present",
    require => Class[ "aptitude" ],
  }

  service { "mysql" :
    ensure => running,
    enable => true,
    require => Package["mysql-server"]
  }
  exec {"setmysqlpassword":
    command => "/usr/bin/mysqladmin -u root PASSWORD ${mysqlPassword}; /bin/true",
    require => [Package["mysql-server", "mysql-client"], Service["mysql"]]
  }
}
