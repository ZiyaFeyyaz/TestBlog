require 'google_calendar_api'

class WelcomeController < ApplicationController
  def index
  end

  def add_google_calendar_event
    GoogleCalendarAPI.add_event
    render :index, notice: "Добавлено событие календаря."
  end
end
