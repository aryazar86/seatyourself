class RemoveResetPassword < ActiveRecord::Migration
  def change
    remove_column :users, :reset_password_token
    remove_column :users, :reset_password_token_expires_at
    remove_column :users, :reset_password_email_sent_at
  end
end
