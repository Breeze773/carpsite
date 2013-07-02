class updatedrupal6 {
include apache2
  file { "/tmp/mod-updates":
    ensure  => directory,
    source  => "puppet:///modules/updatedrupal6/tmp/mod-updates",
    recurse => true,
  }            
  exec { "upgrade modules":
    command  => "/tmp/mod-updates/module-update.sh",
    require  => File[ "/tmp/mod-updates/" ],
    notify   => Service[ "apache2" ]
  }
 }
