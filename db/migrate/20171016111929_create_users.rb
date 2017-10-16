class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.uuid :uuid, index: true
      t.string :secret, index: true

      t.timestamps
    end
  end
end
