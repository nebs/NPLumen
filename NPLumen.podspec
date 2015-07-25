Pod::Spec.new do |s|
  s.name             = "NPLumen"
  s.version          = "0.1.0"
  s.summary          = "Light source management"
  s.description      = <<-DESC
                       NPLumen is an iOS library that allows you to treat
                       UIViews as either light sources or objects which respond
                       to the sources. For example you can have one view cast a
                       relative shadow on other views.
                       DESC
  s.homepage         = "https://github.com/nebspetrovic/NPLumen"
  s.license          = 'MIT'
  s.author           = { "Nebojsa Petrovic" => "nebspetrovic@gmail.com" }
  s.source           = { :git => "https://github.com/nebspetrovic/NPLumen.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/nebsp'
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes/**/*.{h,m}'
  s.resource_bundles = {
    'NPCricket' => ['Pod/Classes/**/*.xib']
  }
  s.public_header_files = 'Pod/Classes/**/*.h'
end
