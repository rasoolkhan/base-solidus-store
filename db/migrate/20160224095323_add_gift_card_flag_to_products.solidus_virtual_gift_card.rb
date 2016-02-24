# This migration comes from solidus_virtual_gift_card (originally 20140702153907)
class AddGiftCardFlagToProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :gift_card, :boolean, default: false
  end
end
