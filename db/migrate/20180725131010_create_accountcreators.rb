class CreateAccountcreators < ActiveRecord::Migration[5.0]
  def change
    create_table :accountcreators do |t|
      t.int :user_id
      t.timestamps
    end
  end
end
