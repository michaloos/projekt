class AddLocationIdToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :location_id, :integer
    add_index :posts, :location_id
  end
end
