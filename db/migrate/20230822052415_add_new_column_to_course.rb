class AddNewColumnToCourse < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :user_type, :string
  end
end
