class AddNameToStorekeeper < ActiveRecord::Migration
  def change
    add_column :storekeepers, :name, :string, null: false
  end
end
