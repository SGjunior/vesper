class SquadController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]
  before_action :set_squad, only: [:show, :edit]

  def edit
    @squad = Squad.find(params[:id])
    authorize @squad
    render 'squad/edit'
  end

  #AJAX REQUEST
  def create

    @squad = Squad.new(user: current_user)
    authorize @squad

    @squad.save!


    params[:chosenVenues].each do |venue_id|
      Squadchosenvenue.new(squad: @squad, venue_id: venue_id).save!
    end

    render json: @squad

    # redirect_to edit_squad(@squad)
  end

  #AJAX REQUESTS
  def refresh_squad_status
    @squad = Squad.find(params[:id])
    #add api logic
  end

  #AJAX REQUESTS
  def update
    # AJAX REQUESTS
    # look for email in users
    #if exists
    user = User.find_by("email = '#{params[:email]}'")
    @squad = Squad.find(params[:id]) #TODO : something along those lines
    authorize @squad
    Squadmember.new(user: user, squad: @squad, squadchosenvenue_id: @squad.squadchosenvenues.first.id).save! #TODO : something along those lines
  end

  #AJAX REQUESTS

  def confirm_squad_member
    @squad = Squad.find(params[:id])

   squadmember = Squadmember.find_by('user_id current_user') # TODO : figure activerecord call to find squadmember id in the good squad and the good user_id

   squadmember.update(params_confirm_squad_member)

  end

  def show
    @squad = Squad.find(params[:id])
    # @squad.update(params_finalize_squad)

    authorize @squad
  end

  # AJAX REQUESTS
  def confirm_squad_order
    # TODO : add some booking logic + return JS to display confirmation report
  end

  # AJAX REQUESTS
  def update_package
    @squad = Squad.find(params[:id])
    @squad.update(params_update_package)
  end

  private

  def params_update_package
    params.require(:squad).permit(:package_id)
  end

  def params_confirm_squad_member
    params.require(:squadmember).permit(:contribution, :squadchosenvenue_id)
  end


  def params_finalize_squad
    # 601:  TODO : fire only when leader clicks on button to go to show page.
    # it's been decided :
    # => jscript will return squadchosenvenue_id of the venue with the highest vote counter on 601 submit
    params.require(:squad).permit(:squadchosenvenue_id)

  end

  def initialize_squad

    squad = Squad.new(user: current_user, night_out: params[:night_out])

    venues = extract_squad_chosen_venues

    venues.each do |venue|
      # new_venue = Squadchosenvenue.new(venue)
      Squadchosenvenue.new(venue: venue, squad: squad).save!
    end

    squad
  end

  def extract_squad_chosen_venues
    #TODO : receive JS http request
  end

  def extract_squad_member
    #TODO : receive JS http requeset and extract squad member
    # params.require(:squadmember).permit(:user)
  end

  def set_squad
    @squad = Squad.find(params[:id])
  end

end
