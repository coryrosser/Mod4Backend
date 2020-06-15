class AddImgToProject < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :img, :string
  end
end
