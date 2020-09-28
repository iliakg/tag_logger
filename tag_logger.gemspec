$:.push File.expand_path('../lib', __FILE__)

require 'tag_logger/version.rb'

Gem::Specification.new do |s|
  s.name      = 'tag_logger'
  s.version   = TagLogger::VERSION
  s.authors   = 'ilia_kg'
  s.email     = 'piryazevilia@gmail.com'
  s.homepage  = 'https://github.com/iliakg/tag_logger'
  s.date      = '2020-09-25'
  s.summary   = 'Simple gem for tag logging'
  s.license   = 'MIT'

  s.files = Dir['lib/**/*', 'LICENSE', 'README.md']
  s.require_paths = ['lib']
end
