class AddPasswordDigestToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :password_digest, :string
  end
end
