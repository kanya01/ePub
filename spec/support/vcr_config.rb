require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
  config.filter_sensitive_data('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') { ENV['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'] }
end