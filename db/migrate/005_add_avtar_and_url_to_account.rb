class AddAvtarAndUrlToAccount < ActiveRecord::Migration
  def self.up
    change_table :accounts do |t|
      t.string :avatar
      t.string :url
    end
  end

  def self.down
    change_table :accounts do |t|
      t.remove :avatar
      t.remove :url
    end
  end
end
