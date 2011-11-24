class MembershipList < ActiveRecord::Base

  def self.current_members
    lists = MembershipList.where(['? BETWEEN start_date AND end_date', Time.now.to_date])
    lists.map do |l|
      l.addresses
    end.join("\r\n").split("\r\n").uniq
  end

  def self.member?(address)
    MembershipList.current_members.include? address
  end
  
end
