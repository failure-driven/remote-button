module PageFragments
  module Welcome
    def message_and_versions
      output = {}
      output[:message] = page.find("h1").text
      version = page.find("p.version")
      output[:rails_version] = version.text[/(Rails version: )(?<version>[^\n]*)/, "version"] # rubocop:disable Lint/MixedRegexpCaptureTypes
      output[:ruby_version] = version.text[/(Ruby version: )(?<version>[^\n]*)/, "version"] # rubocop:disable Lint/MixedRegexpCaptureTypes
      output
    end
  end
end
