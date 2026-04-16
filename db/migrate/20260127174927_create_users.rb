# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :github_uid

      t.timestamps
    end
    add_index :users, :email
    add_index :users, :github_uid
  end
end
