class PrivilegeList < ActiveRecord::Base

  def self.current_members
    # level == 1 => member
    lists = PrivilegeList.where('? BETWEEN start_date AND end_date', Time.now.to_date).where(:level => 1)
    lists.map do |l|
      l.addresses
    end.join("\r\n").split("\r\n").uniq
  end

  def self.current_admins
    # level == 2 => admin
    lists = PrivilegeList.where('? BETWEEN start_date AND end_date', Time.now.to_date).where(:level => 2)
    lists.map do |l|
      l.addresses
    end.join("\r\n").split("\r\n").uniq
  end

  def self.member?(address)
    PrivilegeList.current_members.include? address
  end
  
  def self.admin?(address)
    PrivilegeList.current_admins.include? address
  end

  def level_as_string
    if self.level == 1
      return "Member"
    elsif self.level == 2
      return "Admin"
    else
      return "Unknown"
    end
  end

end
