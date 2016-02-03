class CalculationsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:show, :edit, :update, :destroy] 

  def show
  end

  def new
    @calculation = Calculation.new
  end

  def create
    @calculation = current_user.calculations.build(calculation_params)
    if @calculation.save
      redirect_to @calculation
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @calculation.update_attributes(calculation_params)
      redirect_to @calculation
    else
      render 'edit'
    end
  end

  def destroy
    @calculation.destroy
    redirect_to request.referrer || root_url
  end

  private 
    def calculation_params
      params.require(:calculation).permit(:base_currency, :target_currency, :amount, :nb_weeks)
    end

    def correct_user
      @calculation = current_user.calculations.find_by(params[:id])
      redirect_to root_url if @calculation.nil?
    end
end
