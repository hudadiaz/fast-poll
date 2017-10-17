class AddExpireAtToQuestion < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :expire_at, :datetime
  end
end
