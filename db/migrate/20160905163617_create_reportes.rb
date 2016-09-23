class CreateReportes < ActiveRecord::Migration
  def change
    create_table :reportes do |t|

      t.timestamps null: false
    end
  end
end
