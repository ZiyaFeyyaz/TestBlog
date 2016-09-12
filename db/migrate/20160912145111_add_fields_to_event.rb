class AddFieldsToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :summary, :string
    add_column :events, :location, :string
    add_column :events, :description, :string
    add_column :events, :start_time, :datetime
    add_column :events, :end_time, :datetime
  end
end
