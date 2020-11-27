class CreateModes < ActiveRecord::Migration[6.0]
  def change
    create_table :modes, id: :uuid do |t|
      t.string :name
      t.jsonb :properties

      t.timestamps
    end
  end
end
