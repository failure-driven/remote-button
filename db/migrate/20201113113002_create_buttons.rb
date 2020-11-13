class CreateButtons < ActiveRecord::Migration[6.0]
  def change
    create_table :buttons, id: :uuid do |t|
      t.string :email, null: false
      t.string :site, null: false
      t.string :external_reference, null: false

      t.timestamps
    end
  end
end
