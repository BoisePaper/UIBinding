Pod::Spec.new do |s|


  s.name         = "UIBinding"
  s.version      = "0.1.2"
  s.summary      = "A simple UIBinding Library."

  s.homepage     = "https://github.com/pdavidson/UIBinding"
  s.license = { :type => 'MIT', :text => <<-LICENSE
                   Copyright 2012
                   Permission is granted to...
                 LICENSE
               }
  s.authors       = { "Peter Davidson" => "PeterDavidson@Boiseinc.com", "Joel Sonoda" => "JoelSonoda@Boiseinc.com" }

  s.platform     = :ios, '6.0'
  s.source       = { :git => "https://github.com/pdavidson/UIBinding.git",:tag=>"v0.1.2" }



  s.source_files  = 'Classes', 'Classes/**/*.{h,m}'
  s.exclude_files = 'Classes/Exclude'

  s.public_header_files = 'Classes/UIBinding.h'


  s.requires_arc = true


end
