# frozen_string_literal: true

require_relative "lib/microsoft_action_mailer/version"

Gem::Specification.new do |spec|
  spec.name = "microsoft_action_mailer"
  spec.version = MicrosoftActionMailer::VERSION
  spec.authors = ["Agence Ideematic"]
  spec.email = ["f.didierjean@ideematic.com"]

  spec.summary = "Use Microsoft Graph API with ActionMailer"
  spec.description = "Use Microsoft Graph API with ActionMailer"
  spec.homepage = "https://www.ideematic.com"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://gitub.com/ideematic/microsoft_action_mailer"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "rest-client"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
