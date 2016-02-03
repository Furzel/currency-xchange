class AddUserRefToCalculation < ActiveRecord::Migration
  def change
    add_reference :calculations, :user, index: true, foreign_key: true
    add_index :calculations, [:user_id, :updated_at] 
  end
end
