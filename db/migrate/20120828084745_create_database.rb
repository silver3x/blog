class CreateDatabase < ActiveRecord::Migration
  def self.up

  create_table "user", :force => true do |t|
      t.string "username", :limit => 50
      t.string "password", :limit => 50
      t.string "avatar"
    end

  create_table "post", :force => true do |t|
    t.integer  "user_id"
    t.integer  "poster_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    add_foreign_key(:post, :user_id, :user)
  end

  	create_table "comment", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    add_foreign_key(:comment, :user_id, :user)
    add_foreign_key(:comment, :post_id, :post)
  end


  end

  def self.down
    drop_table :comment
    drop_table :post
    drop_table :user
  end

  def add_foreign_key(from_table, from_column, to_table)
    constraint_name = "fk_#{from_table}_#{from_column}"

    execute %{alter table #{from_table}
              add constraint #{constraint_name}
              foreign key (#{from_column})
              references #{to_table}(id)}
  end

  def remove_foreign_key(from_table, from_column)
    constraint_name = "fk_#{from_table}_#{from_column}"

    execute %{alter table #{from_table}
              drop foreign key #{constraint_name}}
  end
end
