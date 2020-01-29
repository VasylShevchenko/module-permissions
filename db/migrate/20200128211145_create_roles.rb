class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|

      t.string :name,       null: true
      t.jsonb  :permissions, null: true

      t.timestamps
    end
  end
end
