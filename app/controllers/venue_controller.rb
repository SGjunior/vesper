class VenueController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @Venues = policy_scope(Venue).all # ????? -> wtf is this for
    @squad = Squad.new(user: current_user)
  end

  def show
    @Venue = Venue.find(params[:id])
    authorize @venue
  end
end
