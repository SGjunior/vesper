class VenueController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def create
    @venue = Venue.new
    authorize @venue
    # TODO if / else

  end

  def new
    @venue = Venue.new
    authorize @venue
  end

  def edit
    @venue = Venue.find(params[:id])
    authorize @venue
  end

  def update
    @venue = Venue.find(params[:id])
    authorize @venue
    if
      @venue.update(update_venue_params)
      redirect_to venue_path(@venue)
    else
      render "edit"
    end
  end

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

  private

  def update_venue_params
    params.require(:venue).permit(:description, :music_genre, :instagram_handle, :pricing, :capacity, :rating, :review_count, :photo)
  end

end
