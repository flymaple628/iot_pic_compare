class CreateCheckResults < ActiveRecord::Migration
  def change
    create_table :check_results do |t|
    	t.string :account
    	t.boolean :result
      t.timestamps null: false
    end
  end
end
