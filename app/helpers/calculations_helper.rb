module CalculationsHelper
  def table_data(calculation_id)
    Calculation.find_by(id: calculation_id).table_weekly_rates
  end
end
