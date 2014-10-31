class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :artist
  has_one :client
  has_one :band
  accepts_nested_attributes_for :artist, :band, :client
  validates :terms_of_service, acceptance: { accept: 'yes' }
end