class SquadController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]
  before_action :set_squad, only: [:show, :edit]

  def edit
    @squadTotalContribution = find_squad_total_contribution
    @squad = Squad.find(params[:id])
    authorize @squad
    render 'squad/edit'
  end

  #AJAX REQUEST
  def create

    @squad = Squad.new(user: current_user)
    authorize @squad

    @squad.save!

    # binding.pry

    params[:chosenVenues].each do |venue_id|
      Squadchosenvenue.new(squad: @squad, venue_id: venue_id).save!
    end

    Squadmember.new(user: current_user, squad: @squad).save!

    render json: @squad
    # redirect_to edit_squad(@squad)
  end

  def add_sidekick
    @squad = Squad.find(params[:id])
    @squadmember = Squadmember.new
    @searchBar = true;

    authorize @squad
  end

  def member_choose_venue
    @squad = Squad.find(params[:id])
    @squadmember = @squad.squadmembers.find(params[:squad_member_id])

    authorize @squadmember
  end

  def member_confirm_venue
    @squad = Squad.find(params[:id])
    @squadmember = @squad.squadmembers.find(params[:squad_member_id])

    authorize @squadmember

    @squadmember.squadchosenvenue_id = params[:squadchosenvenue_id].to_i
    @squadmember.save!

    if true #passed validations
      render json: { squad: @squad, squadmembers: @squad.squadmembers, status: venue_progess_ready? }
    else
      render json: '????'
    end
  end

  def choose_venue_status
    @squad = Squad.find(params[:id])
    @squadmember = @squad.squadmembers.find_by(user: current_user)
    authorize @squadmember

    render json: { squad: @squad, squadmembers: @squad.squadmembers, status: venue_progess_ready? }
  end

  def member_choose_contribution
    @squad = Squad.find(params[:id])
    @squadmember = @squad.squadmembers.find(params[:squad_member_id])
    @squadChosenVenue = find_squad_chosen_venue

    authorize @squadmember
  end

  def member_confirm_contribution
    @squad = Squad.find(params[:id])
    @squadmember = @squad.squadmembers.find(params[:squad_member_id])

    authorize @squadmember

    if params[:currentaction] != 'status'
      # binding.pry
      @squadmember.contribution = params[:contribution].to_i
      @squadmember.will_be_present = true
      @squadmember.save!

    end
    # binding.pry
    render json: { squad: @squad, squadmembers: @squad.squadmembers, status: contribution_progess_ready? }
  end

  #AJAX REQUESTS
  def refresh_squad_status
    @squad = Squad.find(params[:id])
    #add api logic
  end

  #AJAX REQUESTS

  #AJAX REQUESTS
  def update
    # AJAX REQUESTS
    # look for email in users
    #if exists
    if params[:adding_user_id].nil?
      user = User.find_by("email = '#{params[:email]}'")
    else
      user = User.find(params[:adding_user_id])
    end

    @squad = Squad.find(params[:id]) #TODO : something along those lines
    authorize @squad
    @squadmember = Squadmember.new(user: user, squad: @squad, contribution: 0) #TODO : something along those lines
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
      unless squadmember.squadchosenvenue_id.nil?
        if vote_results[squadmember.squadchosenvenue_id]
          vote_results[squadmember.squadchosenvenue_id] += 1
        else
          vote_results[squadmember.squadchosenvenue_id] = 1
        end
      end
    end
    vote_result = vote_results.max_by{|k,v| v}
    return Squadchosenvenue.find(vote_result[0])
  end

  def find_squad_total_contribution
    contribution = 0;

    @squad.squadmembers.each do |squadmember|
      unless squadmember.contribution.nil?
        contribution += squadmember.contribution
      end
    end

    return contribution

  end

  def venue_progess_ready?
    #todo : calculate if more then half of people have voted yet

    member_count = @squad.squadmembers.count
    member_critial_count = (@squad.squadmembers.count/2.to_f).ceil
    members_have_not_chosen = []

    member_count_have_chosen_venue = 0

    @squad.squadmembers.each do |squadmember|
      if squadmember.squadchosenvenue_id.nil?
        members_have_not_chosen << squadmember
      else
        member_count_have_chosen_venue += 1
      end
    end

    return { ready: member_critial_count == member_count_have_chosen_venue, missing_cnt: member_critial_count - member_count_have_chosen_venue, waiting_for: members_have_not_chosen }
  end

  def contribution_progess_ready?
    #todo : calculate if more then half of people have voted yet

    member_count = @squad.squadmembers.count
    member_critial_count = member_count
    members_have_not_contributed = []

    member_count_have_contributed = 0

    @squad.squadmembers.each do |squadmember|
      if squadmember.contribution == 0
        members_have_not_contributed << squadmember
      else
        member_count_have_contributed += 1
      end
    end

    return { ready: member_critial_count == member_count_have_contributed, missing_cnt: member_critial_count - member_count_have_contributed, waiting_for: members_have_not_contributed }
  end



end
