class drupal6 {
include aptitude

  package { "drupal6" :
    ensure  =>  "present",
    require => Class[ "aptitude" ],
    }
  file { "/etc/apache2/sites-available/default":
    ensure  => present,
    source  => "puppet:///modules/drupal6/etc/apache2/sites-available/default",
    mode    => 644,
    owner   => "root",
    group   => "root",
    require => Package[ "drupal6", "apache2" ],
    notify  => Service[ "apache2" ]
  }
}
