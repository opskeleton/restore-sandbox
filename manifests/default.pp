node default {

  class{'backup::rclone':}
  
  class{'backup::zbackup':}

  file{'/data':
    ensure  => directory
  } ->

  mkfs::device {'/dev/vda':
    dest   => '/data'
  }
}
