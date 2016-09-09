require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

require 'fileutils'
require 'time'

class GoogleCalendarAPI
  OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
  APPLICATION_NAME = 'Test Blog - APP'
  CLIENT_SECRETS_PATH = 'lib/client_secret.json'
  CREDENTIALS_PATH = File.join(Dir.home, '.credentials',
                               "calendar-ruby-quickstart.yaml")
  SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR

  CALENDAR_ID = ENV.fetch('CALENDAR_ID')

  def self.authorize
    FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

    client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
    token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
    authorizer = Google::Auth::UserAuthorizer.new(
      client_id, SCOPE, token_store)
    user_id = 'default'
    credentials = authorizer.get_credentials(user_id)
    if credentials.nil?
      url = authorizer.get_authorization_url(
        base_url: OOB_URI)
      puts "Open the following URL in the browser and enter the " +
           "resulting code after authorization"
      puts url
      code = gets
      credentials = authorizer.get_and_store_credentials_from_code(
        user_id: user_id, code: code, base_url: OOB_URI)
    end
    credentials
  end

  def self.add_event
    start_time = Time.zone.now.to_a
    (0..1).each { |i| start_time[i] = 0 }
    start_time[2] = 13
    end_time = start_time
    end_time[2] = 14

    start_time = Time.local(*start_time).iso8601
    end_time = Time.local(*end_time).iso8601

    event = 
      Google::Apis::CalendarV3::Event.new ({
        summary: 'Test Blog Event',
        location: 'Ростов-на-Дону, ул. города Волос, дом, 135',
        description: 'Обед, перерыв, отдых...',
        start: {
          date_time: start_time
        },
        end: {
          date_time: end_time,
        },
      })

    # Initialize the API
    service = Google::Apis::CalendarV3::CalendarService.new
    service.client_options.application_name = APPLICATION_NAME
    service.authorization = authorize

    result = service.insert_event(CALENDAR_ID, event)
    puts "Event created: #{result.html_link}"
  end
end
