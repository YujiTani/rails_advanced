class AddColumnArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :eyecatch_width , :integer, default: 200
    # 0: center, 1: left, 2: right
    add_column :articles, :eyecatch_position , :integer, default: 0
  end
end
