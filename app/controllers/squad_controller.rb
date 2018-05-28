class SquadController < ApplicationController
  def new
    # if empty params squad_id
    @squad = Squad.new()
    # else
    # @squad = Squad.find
    # end
    authorize @squad
  end

  def show
    # if empty params squad_id
    @squad = Squad.new()
    # else
    # @squad = Squad.find
    # end
    authorize @squad
  end
end
