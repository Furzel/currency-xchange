class AddNbWeeksToCalculation < ActiveRecord::Migration
  def change
    add_column :calculations, :nb_weeks, :integer
  end
end
