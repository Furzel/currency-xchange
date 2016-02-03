class CreateCalculations < ActiveRecord::Migration
  def change
    create_table :calculations do |t|
      t.string :base_currency
      t.string :target_currency
      t.integer :amount
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
