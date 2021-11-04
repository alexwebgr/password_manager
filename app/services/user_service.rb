require 'csv'

class UserService
  ErrorLine = Struct.new(:char, :count)
  MIN_LENGTH = 10
  MAX_LENGTH = 16
  REPEATING_CHARS = 3
  ERROR_FORMAT_REGEX = /('\S') appears (\d)/
  REPEATING_CHARS_REGEX = /(.)\1{2,}/

  def self.create_users(file)
    new(file).create_users
  end

  private

  attr_reader :file

  def initialize(file = nil)
    @file = file
  end

  def parse_csv
    CSV.parse(file, headers: true)
  end

  def parse_error(str)
    str.match(ERROR_FORMAT_REGEX) { |m| ErrorLine.new(*m.captures) }
  end

  def determine_chars(errors, password)
    errors.each_with_object([]) do |error, memo|
      memo << 1 if error.match?(/lowercase/)
      memo << 1 if error.match?(/uppercase/)
      memo << 1 if error.match?(/digit/)
      memo << MIN_LENGTH - password.length if error.match?(/too short/)
      memo << password.length - MAX_LENGTH if error.match?(/too long/)
      memo << parse_error(error).count.to_i - (REPEATING_CHARS - 1) if error.match?(/repeating/)
    end.sum
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
          errors: ''
        }
      else
        {
          name: user['name'],
          message: "Change #{determine_chars(user.errors.full_messages, user['password'])} characters of #{user['name']}'s password",
          errors: user.errors.full_messages.join("<br />")
        }
      end
    end
  end
end