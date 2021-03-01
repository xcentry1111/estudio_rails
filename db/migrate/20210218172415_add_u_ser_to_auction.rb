class AddUSerToAuction < ActiveRecord::Migration[5.1]
  def change
    add_column :auctions, :user_id, :integer
  end
end
