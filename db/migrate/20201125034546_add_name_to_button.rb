class AddNameToButton < ActiveRecord::Migration[6.0]
  def change
    add_column :buttons, :name, :string
  end
end
