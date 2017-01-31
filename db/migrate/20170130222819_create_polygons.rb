class CreatePolygons < ActiveRecord::Migration[5.0]
  def change
    create_table :polygons do |t|

      t.timestamps
    end
  end
end
