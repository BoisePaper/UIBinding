Pod::Spec.new do |s|

  s.name         = "UIBinding"
  s.version      = "0.1.9"
  s.summary      = "A simple UIBinding Library."

  s.homepage     = "https://github.com/BoisePaper/UIBinding"
  s.license = { :type => 'MIT', :text => <<-LICENSE
                   Copyright 2012
                   Permission is granted to...
                 LICENSE
               }
  s.authors       = { "Peter Davidson" => "PeterDavidson@Boiseinc.com", "Joel Sonoda" => "JoelSonoda@Boiseinc.com" }
  s.source       = { :git => "https://github.com/BoisePaper/UIBinding.git",:tag=>"v#{s.version}" }


  s.requires_arc = true
  s.ios.deployment_target     = '6.0'
  s.source_files  = 'Classes'
  s.requires_arc  = true



end
