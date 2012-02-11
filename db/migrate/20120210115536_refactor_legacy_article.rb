class RefactorLegacyArticle < ActiveRecord::Migration
  def change
    change_table :legacy_articles do |t|
      t.remove :potential_paths
      t.remove :author_email
      t.index :old_id
    end
  end
end
