Pod::Spec.new do |s|
  s.name         = "Configuration"
  s.version      = "1.1.0"
  s.summary      = "Configuration is a simple library which aim to simplify use of setting value in a project."
  s.description  = <<-DESC
    Configuration is a simple library which aim to simplify use of setting value in a project.
    By using an abstraction layer, you simply use enum to define all your settings and the protocol used for manage it. UserDefaults built-in protocol.
    
    Support Codable out of the box 💪
  DESC
  s.homepage     = "https://github.com/vincentsaluzzo/configuration"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Vincent Saluzzo" => "vincentsaluzzo@me.com" }
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  s.source       = { :git => ".git", :tag => s.version.to_s }
  s.source_files  = "Sources/**/*"
  s.frameworks  = "Foundation"
end
