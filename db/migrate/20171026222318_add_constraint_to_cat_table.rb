class AddConstraintToCatTable < ActiveRecord::Migration[5.1]
  def change
    change_column :cats, :user_id, :integer, null: false
  end
end
