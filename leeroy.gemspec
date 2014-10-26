lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
    s.name        = "leeroy"
    s.version     = 0.1
    s.platform    = Gem::Platform::RUBY
    s.authors     = ["John Hamelink"]
    s.email       = ["john@johnhamelink.com"]
    s.homepage    = "https://github.com/johnhamelink/leeroy"
    s.summary     = "Quickly see the status of your jenkins jobs"
    s.description = "Leeroy lets you quickly check the status of your jenkins builds from the commandline."

    s.required_rubygems_version = ">= 1.8.23"
    s.rubyforge_project         = "leeroy"
    s.add_dependency "paint", "~> 0.8"
    s.add_dependency "rest-client", "~> 1.7"
    s.add_dependency "trollop", "~> 2.0"

    s.files       = Dir.glob("{bin}/**/*") + %w(LICENSE README.md)
    s.executables = ['leeroy']
end
