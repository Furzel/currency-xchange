class AddIndexToDailyCurrencyRates < ActiveRecord::Migration
  def change
    add_index :daily_currency_rates, [:day, :currency]
  end
end
