class xcode_tools::install {
  if $facts['xcode_tools_present'] == false {

    file {'/private/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress':
      ensure => 'present'
    } ->

    exec {'/usr/bin/xcode-select -r': } ->

    exec { "/usr/sbin/softwareupdate -i \"${xcode_product}\" --verbose":
      logoutput => true,
      timeout   => 0,
    } ->

    exec {'/bin/rm -f /private/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress': }

  }

  if $facts['xcode_license_accepted'] == false and  $facts['xcode_command_line_tools'] == true {
    exec { '/usr/bin/xcodebuild -license accept': }
  }

}
