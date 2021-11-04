class User < ApplicationRecord
  validates :name, presence: true
  validates :password, presence: true, length: { in: UserService::MIN_LENGTH..UserService::MAX_LENGTH }
  validate :check_lowercase_exists?
  validate :check_uppercase_exists?
  validate :check_digit_exists?
  validate :check_repeating_chars?

  def check_lowercase_exists?
    if password&.match(/[a-z]/).nil?
      errors.add(:password, "needs to contain a lowercase character")
    end
  end

  def check_uppercase_exists?
    if password&.match(/[A-Z]/).nil?
      errors.add(:password, "needs to contain a uppercase character")
    end
  end

  def check_digit_exists?
    if password&.match(/[0-9]/).nil?
      errors.add(:password, "needs to contain a digit")
    end
  end

  def check_repeating_chars?
    chars = password&.gsub(UserService::REPEATING_CHARS_REGEX).to_a
    unless chars.empty?
      chars.map { |char| errors.add(:password, "cannot contain three repeating characters in a row, '#{char[0]}' appears #{char.length} times") }
    end
  end
end
