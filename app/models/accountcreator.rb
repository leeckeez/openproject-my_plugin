class Accountcreator < ActiveRecord::Base

  has_attached_file :file
  validates_attachment_presence :file, message: "no file"
  @users

  def self.import(file)

    CSV.foreach(file.path, headers: true) do |row|
      attributes = {login: row['user id'].to_s,
                    firstname: row['first name'].to_s,
                    lastname: row['last name'].to_s,
                    mail: row['email'].to_s}

      group_name = {groupname: row['group name'].to_s}
      begin

        @user = User.find_by_login(row['user id']) || @user = User.new(attributes)
        @group = Group.find_by(group_name) || @group = Group.new(group_name)
        @group.users << @user
        @users << @user
        @user.save!
        @group.save!

      rescue => e
        "#{attributes} #{e.message}"
      end
    end
  end

  def self.createUsers(file)
    CSV.foreach(file.path, headers: true) do |row|
      attributes = {login: row['user id'].to_s,
                    firstname: row['first name'].to_s,
                    lastname: row['last name'].to_s,
                    mail: row['email'].to_s}

      group_name = {groupname: row['group name'].to_s}
      begin

        @user = User.find_by_login(row['user id']) || @user = User.new(attributes)
        @group = Group.find_by(group_name) || @group = Group.new(group_name)
        @group.users << @user
        @user.save!
        @group.save!

      rescue => e
        "#{attributes} #{e.message}"
      end
    end
  end

  def self.getUsers
    @Users
  end

end
