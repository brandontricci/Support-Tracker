class CreateSupportRequests < ActiveRecord::Migration
  def change
    create_table :support_requests do |t|
      t.string :name
      t.string :email
      t.string :department
      t.boolean :done, default: false
      t.text :message

      t.timestamps
    end

    add_index :support_requests, :name
    add_index :support_requests, :email
    add_index :support_requests, :message
  end
end
