class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events, id: :uuid do |t|
      t.references :button, type: :uuid, index: true, null: false
      t.jsonb :data

      t.datetime :created_at, null: false
    end
  end
end
