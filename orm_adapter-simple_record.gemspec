# -*- encoding: utf-8 -*-
require File.expand_path('../lib/orm_adapter-simple_record/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["arukoh"]
  gem.email         = ["arukoh10@gmail.com"]
  gem.description   = %q{"Adds Amazon SimpleDB adapter to orm_adapter (https://github.com/ianwhite/orm_adapter/) which provides a single point of entry for using basic features of popular ruby ORMs."}
  gem.summary       = %q{Adds Amazon SimpleDB ORM adapter to the orm_adapter project}
  gem.homepage      = "https://github.com/arukoh/orm_adapter-simple_record"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "orm_adapter-simple_record"
  gem.require_paths = ["lib"]
  gem.version       = OrmAdapter::SimpleRecord::VERSION

  gem.add_dependency "orm_adapter"
  gem.add_dependency "simple_record", ">= 2.2.0"

  gem.add_development_dependency "rake", ">= 0.8.7"
  gem.add_development_dependency "rspec", ">= 2.4.0"
  gem.add_development_dependency "active_support"
  gem.add_development_dependency "i18n"
end
