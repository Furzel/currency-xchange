module CalculationsHelper
  def table_data(calculation_id)
    Calculation.find_by(id: calculation_id).table_weekly_rates
  end

  def format_number(value, precision = 4)
    ActionController::Base.helpers.number_with_precision(value, precision: precision)
  end

  def format_percentage(value, precision = 4)
    ActionController::Base.helpers.number_to_percentage(value, precision: precision)
  end

  def format_currency(value, currency)
    ActionController::Base.helpers.number_to_currency(value, unit: currency)
  end
end
