class CreateDailyCurrencyRates < ActiveRecord::Migration
  def change
    create_table :daily_currency_rates do |t|
      t.date :day
      t.string :currency
      t.text :rates

      t.timestamps null: false
    end
  end
end
