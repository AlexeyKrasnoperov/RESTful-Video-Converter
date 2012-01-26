class AddFlvToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :flv_converted, :string
  end
end
