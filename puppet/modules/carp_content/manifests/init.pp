class carp_content inherits mysql {
$tarball = "carpSite05-22-13.tgz"
$sqlDump = "sqloutput-06-12-2013.sql.gz"
  exec {"import data":
    command => "/bin/gunzip < /tmp/${sqlDump} | /usr/bin/mysql -u root -p${mysqlPassword} drupal6",
    require => [Class[ "mysql" ], File[ "/tmp/${sqlDump}" ], Exec[ "recreate db" ]],
    notify  => Service[ "apache2" ]
  }
  file { "/tmp/${sqlDump}":
    ensure  => file,
    mode    => 644,
    source  => "puppet:///modules/carp_content/tmp/${sqlDump}",
  }
  file { "/tmp/${tarball}" :
    ensure => file,
    mode   => 644,
    source => "puppet:///modules/carp_content/tmp/${tarball}"
  }
##After this gets untarred will have to set ownership root:root owns everything
##also need to change dbconfig file to 644 after it gets untarred
  exec { "untarModules":
    command => "/bin/tar --strip-components=1 -C /usr/share/drupal6/ -xzvf /tmp/${tarball}",
    cwd     => "/tmp",
    require => [File[ "/tmp/${tarball}" ], Class[ "drupal6" ]],
    notify  => Service[ "apache2" ]
  }
  exec { "recreate db":
    command => "/tmp/create-db.sh",
    require => [File[ "/tmp/create-db.sh" ], Class[ "drupal6" ]]
  }
  file { "/usr/share/drupal6/sites/default/dbconfig.php":
    ensure  => present,
    mode    => 644,
    owner   => "root",
    group   => "root",
    require => Exec[ "untarModules" ]

  }
  file { "/tmp/create-db.sh":
    ensure => present,
    mode   => 755,
    source => "puppet:///modules/carp_content/tmp/create-db.sh",

  }
  file { "/usr/share/drupal6/":
    ensure  => directory,
    owner   => "www-data",
    group   => "root",
    recurse => "true",
    require => Exec[ "untarModules" ]

  }
}
