class User < ActiveRecord::Base
  attr_accessor :password

  before_save do
    self.email = email.downcase
  end

  before_save :encrypt_password

  validates :email, presence: true, uniqueness: true
  validates_presence_of :password, :on => :create, :if => :password_validatible?

  def self.authenticate_user!(username, password)
    user = find_by_username(username)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      false
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  private

  def password_validatible?
    password.present? || new_record?
  end
end
