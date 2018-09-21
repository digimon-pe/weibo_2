require File.expand_path('lib/weibo_2/version', __dir__)

Gem::Specification.new do |gem|
  gem.authors       = ['simsicon']
  gem.email         = ['simsicon@gmail.com']
  gem.description   = "WeioOAuth2 is a Ruby gem that provides a wrapper for interacting with sina weibo's v2 API,
                         which is currently the latest version. The output data format is Hashie::Mash"
  gem.summary       = 'A oauth2 gem for weibo'
  gem.homepage      = 'http://github.com/simsicon/weibo_2'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'weibo_2'
  gem.require_paths = ['lib']
  gem.version       = WeiboOAuth2::Version
  gem.required_ruby_version = '>= 2.3'

  gem.add_runtime_dependency 'hashie', '> 2.0.4'
  gem.add_runtime_dependency 'multi_json', '~> 1'
  gem.add_runtime_dependency 'oauth2', '> 1.3.0'
  gem.add_runtime_dependency 'rest-client', '> 1.7.3'
end
