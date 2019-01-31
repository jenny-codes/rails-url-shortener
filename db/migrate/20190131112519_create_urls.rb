class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls do |t|
      t.string :original_url
      t.string :shortened_url
      t.integer :count, default: 0

      t.timestamps
    end
    add_index :urls, :shortened_url, unique: true
  end
end
