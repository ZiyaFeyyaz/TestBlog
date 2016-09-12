require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

require 'fileutils'
require 'time'

class GoogleCalendarAPI
  OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
  APPLICATION_NAME = 'Test Blog - APP'
  CLIENT_SECRETS_PATH = ENV.fetch('CLIENT_SECRETS_PATH')
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

  # Initialize the API
  SERVICE = Google::Apis::CalendarV3::CalendarService.new
  SERVICE.client_options.application_name = APPLICATION_NAME
  SERVICE.authorization = authorize

  def self.add_event(event)
    result = SERVICE.insert_event(CALENDAR_ID, event)
    puts "Event created: #{result.html_link}"
    result.id
  end

  def self.delete_event
    event = Event.all.first
    result = SERVICE.delete_event(CALENDAR_ID, event.event_id)
    if result.blank?
      event.destroy
    end
  end

  def self.new_event(event)
    Google::Apis::CalendarV3::Event.new ({
      summary: event.summary,
      location: event.location,
      description: event.description,
      start: {
        date_time: event.start_time.iso8601
      },
      end: {
        date_time: event.end_time.iso8601,
      },
    })
  end
end
