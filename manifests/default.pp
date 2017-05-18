node default {
  $device = hiera('restore::device')

  include apt

  class{'backup::rclone':}
  
  class{'backup::zbackup':}

  $user = hiera('user')

  file{'/data':
    ensure => directory,
    owner  => $user
  } ->

  mkfs::device { $device:
    dest   => '/data'
  }
}
