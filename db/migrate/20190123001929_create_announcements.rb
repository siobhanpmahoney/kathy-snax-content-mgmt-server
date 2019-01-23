class CreateAnnouncements < ActiveRecord::Migration[5.2]
  def change
    create_table :announcements do |t|
      t.string :headline
      t.text :content
      t.string :img_link
      t.string :audio_link
      t.string :embed_link
      t.string :video_link

      t.timestamps
    end
  end
end
