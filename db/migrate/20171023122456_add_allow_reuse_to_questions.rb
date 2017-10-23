class AddAllowReuseToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :allow_reuse, :boolean
  end
end
