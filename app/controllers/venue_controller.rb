class VenueController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :welcome]

  def welcome
    @venue = Venue.first
    authorize @venue
  end


  def index
    @squad = Squad.new(user: current_user)

    @Venues = policy_scope(Venue).where.not(latitude: nil, longitude: nil).limit(20)

    @markers = @Venues.map do |venue|
      {
        lat: venue.latitude,
        lng: venue.longitude,
        # infoWindow: { content: 'you are here' }
        # infoWindow: { content: render_to_string(partial: "venue/index_components/venue_card", locals: { venue: venue }) }
      }
    end
  end

  def show
    @venue = Venue.find(params[:id])
    authorize @venue

    @markers = [{
      lat: @venue.latitude,
      lng: @venue.longitude
    }]
  end
end
