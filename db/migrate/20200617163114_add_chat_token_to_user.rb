class AddChatTokenToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :chat_token, :string
  end
end
