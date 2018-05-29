class VenueController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @venues = policy_scope(Venue).all # ????? -> wtf is this for
  end

  def show
    @venue = Venue.find(params[:id])
    authorize @venue
  end
end
