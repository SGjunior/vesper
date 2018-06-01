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

    Squadmember.new(user: current_user, squad: @squad, squadchosenvenue_id: @squad.squadchosenvenues.first.id).save!



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
    @squadmember = Squadmember.new(user: user, squad: @squad, squadchosenvenue: @squad.squadchosenvenues.first, contribution: 0) #TODO : something along those lines
    @squadmember.save!
    respond_to do |format|
    format.js
    end
  end
  #AJAX REQUESTS

  def confirm_squad_member
   @squad = Squad.find(params[:id])

   squadmember = @squad.squadmembers.find_by(user: current_user)
   squadmember.squadchosenvenue_id = params[:squadchosenvenue_id].to_i
   squadmember.contribution = params[:contribution].to_i
   squadmember.will_be_present = params[:will_be_present]
   squadmember.save!

   authorize squadmember

   render json: @squad
  end

  def show
    @squad = Squad.find(params[:id])
    @squadChosenVenue = find_squad_chosen_venue
    @squadTotalContribution = find_squad_total_contribution
    # raise
    authorize @squad
  end

  # AJAX REQUESTS
  def confirm_squad_order
    # TODO : add some booking logic + return JS to display confirmation report
    @squad = Squad.find(params[:id])
    authorize @squad

    @squad.update(confirmed: true)


    respond_to do |format|
      format.js
    end

  end

  # AJAX REQUESTS
  def update_package
    @squad = Squad.find(params[:id])
    @package = Package.find(params[:package_id])
    @squad.update(package_id: @package.id)
    authorize @squad

    respond_to do |format|
      format.js
    end
  end

  private

  def params_update_package
    params.require(:squad).permit(:package_id)
  end

  def params_finalize_squad
    # 601:  TODO : fire only when leader clicks on button to go to show page.
    # it's been decided :
    # => jscript will return squadchosenvenue_id of the venue with the highest vote counter on 601 submit
    params.require(:squad).permit(:squadchosenvenue_id)

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

  def find_squad_chosen_venue
    vote_results = {}
    @squad.squadmembers.each do |squadmember|
      if vote_results[squadmember.squadchosenvenue]
        vote_results[squadmember.squadchosenvenue] += 1
      else
        vote_results[squadmember.squadchosenvenue] = 1
      end
    end
    vote_result = vote_results.max_by{|k,v| v}
    return vote_result[0]
  end

  def find_squad_total_contribution
    contribution = 0;

    @squad.squadmembers.each do |squadmember|
      # contribution += squadmember.contribution
    end

    return contribution

  end
end
