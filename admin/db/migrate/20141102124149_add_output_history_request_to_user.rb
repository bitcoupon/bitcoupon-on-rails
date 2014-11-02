# AddOutputHistoryRequestToUser
class AddOutputHistoryRequestToUser < ActiveRecord::Migration
  def change
    add_column :users, :output_history_request, :string
  end
end
