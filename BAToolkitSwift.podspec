#
#  Be sure to run `pod spec lint BAToolkitSwift.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#  To submit, run `pod trunk push BAToolkitSwift.podspec`
#

Pod::Spec.new do |s|

  s.name         = "BAToolkitSwift"
  s.version      = "0.1.11"
  s.summary      = "An iOS app building toolkit in Swift."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC

  The code was adapt from an active project running Swift 4 (using Xcode 9). The toolkit holds extension functions and extended/customized class that ease development of iOS app (can be inherited by Swift classes or used by Objective-C classes)

                   DESC

  s.homepage     = "https://github.com/johncpang/BAToolkitSwift"
  s.source       = { :git => "https://github.com/johncpang/BAToolkitSwift.git", :tag => "#{s.version}" }
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "John Pang" => "john@brewingapps.com" }
  s.social_media_url   = "https://twitter.com/johncpang"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  s.platform     = :ios
  s.ios.deployment_target = "9.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

# s.source_files  = "BAToolkitSwift", "BAToolkitSwift/**/*.{h,m,swift}"
  s.exclude_files = "BAToolkitSwift/Exclude"

  s.subspec 'Extensions' do |ss|
    ss.source_files = "BAToolkitSwift/Extensions/*.{h,m,swift}"
  end

  s.subspec 'ViewControllers' do |ss|
    ss.source_files = "BAToolkitSwift/ViewControllers/*.{h,m,swift}"
    ss.dependency 'BAToolkitSwift/Extensions'
  end

  s.subspec 'Views' do |ss|
    ss.source_files = "BAToolkitSwift/Views/*.{h,m,swift}"
    ss.dependency 'BAToolkitSwift/Extensions'
  end

  s.subspec 'Extras' do |ss|
    ss.source_files = "BAToolkitSwift/Extras/*.{h,m,swift}"
    ss.dependency 'BAToolkitSwift/Extensions'
  end

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
