class AddCheckResault < ActiveRecord::Migration
  def change
  	add_column :check_results, :pixels_total, :string
  	add_column :check_results, :pixels_changed, :string
  	add_column :check_results, :pixels_changed_percen, :string
  end
end
