# restore main module
class restore {
  class{'backup::rclone':}
  
  class{'backup::zbackup':}

  file{'/data':
    ensure  => directory
  } ->

  mkfs::device {'/dev/xvdh':
    dest   => '/data'
  }


}
