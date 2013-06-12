class carp_content inherits mysql {

  exec {"import data":
    command => "/bin/gunzip < /tmp/carp_website_backup-may-21-2013.sql.gz | /usr/bin/mysql -u root -p${mysqlPassword} drupal6",
    require => [Class[ "mysql" ], File[ "/tmp/carp_website_backup-may-21-2013.sql.gz" ]]
  }
  file { "/tmp/carp_website_backup-may-21-2013.sql.gz":
    ensure  => present,
    mode    => 644,
    source  => "puppet:///modules/carp_content/tmp/carp_website_backup-may-21-2013.sql.gz",

  }
}
