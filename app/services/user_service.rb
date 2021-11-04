require 'csv'

class UserService
  def self.create_users(file)
    new(file).create_users
  end

  private

  attr_reader :file

  def initialize(file)
    @file = file
  end

  def parse_csv
    CSV.parse(file, headers: true)
  end

  public

  def create_users
    parse_csv.map do |user|
      next unless user['name'] && user['password']

      user = User.new({
                        name: user['name'],
                        password: user['password']
                      })

      if user.save
        {
          name: user.name,
          message: 'Import was successful',
          success: true
        }
      else
        {
          name: user['name'],
          message: user.errors.full_messages.join("\n")
        }
      end
    end
  end
end