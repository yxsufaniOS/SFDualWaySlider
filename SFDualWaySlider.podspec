
Pod::Spec.new do |s|
  s.name         = "SFDualWaySlider"
  s.version      = “0.9.1”
  s.summary      = "A dual way slider“
  s.description  = <<-DESC
                   DESC

  s.homepage     = "https://github.com/yxsufaniOS/SFDualWaySlider"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "sufan" => "yxsufan@163.com" }
  s.platform     = :ios, “7.0”
  s.source       = { :git => "https://github.com/yxsufaniOS/SFDualWaySlider.git", :tag => s.version }
  s.source_files  = "SFDualWaySlider/SFDualWaySlider/*”
  s.requires_arc  = true
  s.framework     = 'Foundation', 'UIKit'  
  s.dependency    = ‘Masonry’
end
