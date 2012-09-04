class CreateDatabase < ActiveRecord::Migration
  def self.up

  	create_table "comment", :primary_key => "comment_id", :force => true do |t|
    t.integer  "post_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    end

    create_table "post", :primary_key => "post_id", :force => true do |t|
      t.integer  "user_id"
      t.text     "content"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "poster_id"
    end

    create_table "user", :primary_key => "user_id", :force => true do |t|
      t.string  "username",  :limit => 50
      t.string  "password",  :limit => 50
      t.string  "avatar"
      t.integer "user_type",               :default => 0
    end
  end

  def self.down
    drop_table :comment
    drop_table :post
    drop_table :user
  end
end
