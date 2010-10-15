Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '1.3.7'

  s.name              = 'doc_scan'
  s.version           = '0.0.0'
  s.date              = '2010-10-15'
  s.rubyforge_project = 'doc_scan'

  s.summary     = "Utils to get infomration from documents in a folder (doc, pdf, djvu, etc.)"
  s.description = "Utils to get infomration from documents in a folder (doc, pdf, djvu, etc.)"

  s.authors  = ["Emmanuel Oga"]
  s.email    = 'EmmanuelOga@gmail.com'
  s.homepage = 'http://github.com/emmanueloga'

  s.require_paths = %w[lib]

  s.rdoc_options = ["--charset=UTF-8"]
  s.extra_rdoc_files = %w[LICENSE]

  s.add_dependency('risbn')

  s.add_development_dependency('rspec')

  # = MANIFEST =
  s.files = %w[
    LICENSE
    README.md
    Rakefile
    doc_scan.gemspec
    lib/doc_scan.rb
    lib/doc_scan/document.rb
    lib/doc_scan/name_cleaner.rb
    lib/doc_scan/scanner.rb
    spec/doc_scan/document_spec.rb
    spec/doc_scan/name_cleaner_spec.rb
    spec/doc_scan/scanner_spec.rb
    spec/spec_helper.rb
  ]
  # = MANIFEST =

  s.test_files = s.files.select { |path| path =~ /^test\/test_.*\.rb/ }
end
