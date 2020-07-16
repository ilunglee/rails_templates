require 'rack_session_access/capybara' # Access to rack session
require 'screen-recorder' # Record Rspec as video
require 'fileutils'
require 'webdrivers'

Capybara.register_driver(:chrome) do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument '--window-size=1024,768'
  options.add_argument '--no-sandbox'

  unless ENV['SPEC_LIVE_BROWSING'].eql?('true')
    options.add_argument '--headless'
    options.add_argument '--disable-gpu'
  end
  Capybara::Selenium::Driver.new(app, browser: :chrome, native_displayed: false, options: options)
end

Capybara.javascript_driver = :webkit
Capybara.default_driver = :chrome
Capybara.default_max_wait_time = 5

# Screen Recording helper
module SpecRecorderHelper

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def record_screen(page, filename = nil)
    filename = filename.presence ||  @path.split('/').last

    if ENV['SPEC_LIVE_BROWSING'].eql?('true') && ENV['SPEC_LIVE_RECORDING'].eql?('true')
      page.driver.browser.manage.window.move_to(0, 0)
      # page.driver.browser.manage.window.maximize
      sleep 3
      advanced = { input: { framerate: 30 }, output: { r: 15 } }
      recorder =
        ScreenRecorder::Desktop.new(output: "#{@path}/#{filename}.mkv",
                                    advanced: advanced)
      recorder.start
      yield
      recorder.stop
      pd = (ENV['SPEC_LIVE_RECORDING_PIXEL_DENSITY'].presence || 2).to_i
      options = {
        resolution: '1024x768', custom: ['-vf', "crop=#{1024 * pd}:#{768 * pd}:0:#{22 * pd}"]
      }

      recorder.video.transcode("#{@path}/#{filename}.mp4", options)
      recorder.delete
    else
      yield
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

end

# Screenshot helper
module SpecScreenShotHelper

  def screenshot(page, filename)
    page.execute_script("$('body').addClass('spec-helper')")
    return unless ENV['SPEC_LIVE_BROWSING'].eql?('true') && ENV['SPEC_LIVE_SREENSHOT'].eql?('true')

    yield(page) if block_given?

    page.save_screenshot("#{@path}/#{filename}.png")
    sleep((ENV['SPEC_LIVE_BROWSING_SLEEP'] || 1).to_i)
  end

end

RSpec.configure do |config|
  config.include SpecScreenShotHelper, type: :feature
  config.include SpecRecorderHelper, type: :feature

  # Set file path for recording and screenshots
  config.before(:each, type: :feature) do |example|
    @screenshot_path =
      [
        example.metadata[:example_group][:file_path].gsub('.rb', ''),
        example.metadata[:example_group][:description],
        example.metadata[:description]
      ].reject(&:blank?).map(&:downcase).map { |x| x.strip.tr(' ', '_') }.join('/')
    @path = "tmp/capybara/#{@screenshot_path[2..-1]}"

    if ENV['SPEC_LIVE_BROWSING'].eql?('true') &&
       (ENV['SPEC_LIVE_RECORDING'].eql?('true') || ENV['SPEC_LIVE_SREENSHOT'].eql?('true'))

      if Dir.exist?(@path)
        FileUtils.rm_rf("#{@path}/*")
      else
        FileUtils.mkdir_p(@path)
      end
    end
  end
end
