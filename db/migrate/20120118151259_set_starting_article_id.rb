class SetStartingArticleId < ActiveRecord::Migration
  def up
    execute('ALTER SEQUENCE articles_id_seq RESTART 10000;')
  end

  def down
  end
end
