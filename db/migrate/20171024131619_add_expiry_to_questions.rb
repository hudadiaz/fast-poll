class AddExpiryToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :expiry, :date
  end
end
