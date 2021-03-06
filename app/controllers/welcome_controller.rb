require 'google_calendar_api'

class WelcomeController < ApplicationController
  def index
  end

  def add_google_calendar_event
    GoogleCalendarAPI.add_event
    flash[:success] = "Создано новое событие календаря."
    render :index
  end

  def delete_google_calendar_event
    GoogleCalendarAPI.delete_event
    flash[:success] = "Событие календаря удалено."
    render :index
  end
end
