# This migration comes from solidus_virtual_gift_card (originally 20140627185148)
class AddTimestampsToGiftCards < ActiveRecord::Migration
  def change
    add_column :spree_virtual_gift_cards, :created_at, :datetime
    add_column :spree_virtual_gift_cards, :updated_at, :datetime
  end
end
