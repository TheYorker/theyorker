class AddRankToSections < ActiveRecord::Migration

  def change
    add_column :sections, :rank, :integer
    Section.reset_column_information
    say_with_time "Updating Ordering" do
      Section.all.each do |s|
        s.update_attributes :rank => s.id
      end
    end
  end
  
end
