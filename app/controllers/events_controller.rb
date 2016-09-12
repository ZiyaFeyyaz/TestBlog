require 'google_calendar_api'

class EventsController < ApplicationController
  # before_filter :authenticate_user!, except: [:show, :index]

  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  # GET /events/1/edit
  # def edit
  # end

  def create
    @event = Event.new(event_params)
    calendar_event = GoogleCalendarAPI.new_event(@event)
    event_id = GoogleCalendarAPI.add_event calendar_event
    @event.event_id = event_id

    respond_to do |format|
      if @event.event_id.present? && @event.save
        flash[:success] = 'Event was successfully created.'
        format.html { redirect_to @event }
        format.json { render :show, status: :created, location: @event }
      else
        flash[:error] = 'Event not created.'
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  # def update
  #   respond_to do |format|
  #     if @event.update(event_params)
  #       format.html { redirect_to @event, notice: 'Event was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @event }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @event.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def destroy
    result = GoogleCalendarAPI.delete_event @event
    respond_to do |format|
      if result.blank?
        @event.destroy
        flash[:success] = 'Event was successfully destroyed.'
        format.html { redirect_to events_url }
        format.json { head :no_content }
      else
        flash[:error] = 'Error!!! Event not destroyed.'
        format.html { redirect_to events_url }
      end
    end
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:summary, :location, :description, :start_time, :end_time)
    end
end
