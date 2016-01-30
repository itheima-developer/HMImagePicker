Pod::Spec.new do |s|
  s.name         = "HMImagePicker"
  s.version      = "1.0.1"
  s.summary      = "轻量级图像选择框架"
  s.homepage     = "https://github.com/itheima-developer/HMImagePicker"
  s.license      = "MIT"
  s.author       = { "黑马程序员" => "ios@itcast.cn" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/itheima-developer/HMImagePicker.git", :tag => s.version }
  s.source_files  = "HMImagePicker/HMImagePicker/*.{h,m}"
  s.requires_arc = true
end
