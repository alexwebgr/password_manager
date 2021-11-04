class User < ApplicationRecord
  validates :name, presence: true
  validates :password, presence: true, length: { in: 10..16 }
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
    unless password&.match(/(.)\1{2,}/).nil?
      errors.add(:password, "cannot contain three repeating characters in a row")
    end
  end
end
