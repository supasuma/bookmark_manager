require_relative '../data_mapper_setup'
require 'dm-validations'
require 'bcrypt'
require 'securerandom'

class User
  include DataMapper::Resource

  property :id,     Serial
  property :email,  String, required: true, unique: true, format: :email_address
  property :password, BCryptHash
  property :token, String
  property :time, Time

  attr_reader :password
  attr_accessor :password_confirmation

  validates_confirmation_of :password
  validates_format_of :email, as: :email_address
  validates_uniqueness_of :email

  def self.authenticate(email, password)
    user = first(email: email)
    if user && BCrypt::Password.new(user.password) == password
      user
    else
      nil
    end
  end

  def self.reset_password(token, password, password_confirmation)
    user = first(token: token)
    if user.nil?
      :wrong_token
    elsif user.time < Time.now
      :expired_token
    else
      user.update(password: password, password_confirmation: password_confirmation, token: nil)  
    end
  end

  def self.send_token(email)
    user = User.first(:email => email)
    user.update(token: SecureRandom.hex, time: (Time.now + 60 * 60))
  end

end
