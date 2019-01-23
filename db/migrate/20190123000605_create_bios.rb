class CreateBios < ActiveRecord::Migration[5.2]
  def change
    create_table :bios do |t|
      t.text :content

      t.timestamps
    end
  end
end
