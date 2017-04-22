node default {
  $device = hiera('restore::device')

  include apt

  class{'backup::rclone':}
  
  class{'backup::zbackup':}

  file{'/data':
    ensure  => directory
  } ->

  mkfs::device { $device:
    dest   => '/data'
  }
}
