
Pod::Spec.new do |s|
  s.name             = 'BorderLabelTextField'
  s.version          = 'v1.0.0'
  s.swift_version = '5.1'
  s.summary          = 'BorderLabelTextField is a subclass of UITextField that adds a label above the input that breaks the border of the UITextField.'


  s.description      = <<-DESC
  Space remains a crucial aspect in mobile Apps.
  While a label that shifts up or disappears when the TextField is selected works, it somehow limits the value of labels.
  Using a label that sits right between the border of the TextField itself consumes less space
  and makes the label visible at any time, without drawing too much attention from the user,
  since there is no unnecessary animation required for the label which improves overall UX.
                       DESC

  s.homepage         = 'https://github.com/broken-bytes/BorderLabelTextField'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'broken-bytes' => 'dev@broken-bytes.io' }
  s.source           = { :git => 'https://github.com/broken-bytes/BorderLabelTextField.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'

  s.source_files = 'Sources/*.swift'

end
