# This migration comes from solidus_virtual_gift_card (originally 20140624175113)
class SeedGiftCardCategory < ActiveRecord::Migration
  def change
    Spree::StoreCreditCategory.find_or_create_by(name: 'Gift Card')
  end
end
