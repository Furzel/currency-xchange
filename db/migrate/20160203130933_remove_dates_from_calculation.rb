class RemoveDatesFromCalculation < ActiveRecord::Migration
  def change
    remove_column :calculations, :start_date, :date
    remove_column :calculations, :end_date, :date
  end
end
