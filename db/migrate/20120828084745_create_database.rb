class CreateDatabase < ActiveRecord::Migration
  def self.up

  	create_table "comment", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post", :force => true do |t|
    t.integer  "user_id"
    t.integer  "poster_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user", :force => true do |t|
    t.string "username", :limit => 50
    t.string "password", :limit => 50
    t.string "avatar"
  end
  end

  def self.down
    drop_table :comment
    drop_table :post
    drop_table :user
  end
end
