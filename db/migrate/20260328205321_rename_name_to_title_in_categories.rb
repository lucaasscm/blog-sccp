class RenameNameToTitleInCategories < ActiveRecord::Migration[8.1]
  def change
    rename_column :categories, :name, :title
  end
end
