class AddBannerImgToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :banner_img, :string
  end
end
