require "capybara/rspec"
require "capybara/cuprite"

Capybara.server = :puma, { Silent: true }

Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(app, window_size: [1200, 800], browser_options: { "no-sandbox": nil })
end
Capybara.default_driver = :cuprite

Capybara.configure do |config|
  config.default_max_wait_time = ENV["TEST_WAIT_TIME"].present? ? ENV["TEST_WAIT_TIME"].to_i : 7
  config.ignore_hidden_elements = true
  config.visible_text_only = true
  config.match = :prefer_exact
end
