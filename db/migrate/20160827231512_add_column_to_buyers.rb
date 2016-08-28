class AddColumnToBuyers < ActiveRecord::Migration[5.0]
  def change
    add_column :buyers, :password_digest, :string
  end
end
