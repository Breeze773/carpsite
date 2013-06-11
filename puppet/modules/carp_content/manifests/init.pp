class carp_content {

  exec {"echo hello":
    command => "//bin/echo hi | /bin/cat >> /tmp/hi.txt",
    require => Class[ "mysql" ]
  }
}
