class carp_content inherits mysql {
$tarball = "carpSite05-22-13.tgz"
$sqlDump = "carp_website_backup-may-21-2013.sql.gz"
  exec {"import data":
    command => "/bin/gunzip < /tmp/${sqlDump} | /usr/bin/mysql -u root -p${mysqlPassword} drupal6",
    require => [Class[ "mysql" ], File[ "/tmp/${sqlDump}" ], Exec[ "recreate db" ]]
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
  exec { "untarModules":
    command => "/bin/tar --strip-components=1 -C /usr/share/drupal6/ -xzvf /tmp/${tarball}",
    cwd     => "/tmp",
    require => [File[ "/tmp/${tarball}" ], Class[ "drupal6" ]]
  }
  exec { "recreate db":
    command => "/tmp/create-db.sh",
    require => [File[ "/tmp/create-db.sh" ], Class[ "drupal6" ]]
  }
  file { "/tmp/create-db.sh":
    ensure => present,
    mode   => 755,
    source => "puppet:///modules/carp_content/tmp/create-db.sh",

  }
}
