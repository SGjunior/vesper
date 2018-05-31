class VenueController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @Venues = policy_scope(Venue).all # ????? -> wtf is this for
    @squad = Squad.new(user: current_user)


    @venues_on_map = Venue.where.not(latitude: nil, longitude: nil)

    @markers = @venues_on_map.map do |venue|
      {
        lat: venue.latitude,
        lng: venue.longitude,
        # infoWindow: { content: 'you are here' }
        # infoWindow: { content: render_to_string(partial: "venue/index_components/venue_card", locals: { venue: venue }) }
      }
    end

    # raise



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
