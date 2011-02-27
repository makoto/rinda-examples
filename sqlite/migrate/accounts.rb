class CreateLogTables < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
                        t.integer :account_id
    end

  end
end