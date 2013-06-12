class apache2 {
include aptitude
  package { "apache2" :
    ensure  =>  "present",
    require => Class[ "aptitude" ],
    }
  service { "apache2" :
    ensure => running,
    enable => true,
    require => Package["apache2"]
  }
  file { "/etc/apache2/mods-enabled/rewrite.load":
    ensure => link,
    target => "/etc/apache2/mods-available/rewrite.load",
    require => Package["apache2"]
  }
}
