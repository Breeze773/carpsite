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
}
