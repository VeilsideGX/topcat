class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable.
  extend FriendlyId
  friendly_id :name, use: :slugged

  enum approve_status: [:pending, :approved]
  enum user_type: [:not_assign, :artist, :band, :client]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
 
  has_one :artist, dependent: :destroy
  has_one :client, dependent: :destroy
  has_one :band, dependent: :destroy
  has_many :sent_messages, :class_name => 'Message', :foreign_key=> 'sender_id'
  has_many :received_messages, :class_name => 'Message', :foreign_key=> 'receiver_id'
    
  def messages
    sent_messages + received_messages
  end
  
  def conversations(user_id)
    Message.where("(sender_id=? and receiver_id=?) or (sender_id=? and receiver_id=?)", user_id, self.id, self.id, user_id).order('created_at')
  end
  
  def all_conversations
    result = {}
    messages.map(&:receiver_id).uniq.each do |user_id|
      result[user_id] = conversations(user_id)
    end
    result
  end
 
  def name
    return self.artist.full_name if self.artist
    return self.band.band_name if self.band
    return self.client.company_name if self.client
  end

  accepts_nested_attributes_for :artist, :band, :client
  validates :terms_of_service, acceptance: { accept: 'yes' }

  has_attached_file :profile_pic, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "missing.jpg"
  
  validates_attachment_content_type :profile_pic, :content_type => /\Aimage\/.*\Z/, :less_than => 1.megabytes

  scope :not_assign_user, -> { where(user_type: 0)}

  delegate :full_name, to: :artist, prefix: :artist
  delegate :music_genre, to: :artist, prefix: :artist
  delegate :band_name, to: :band
  delegate :music_genre, to: :band, prefix: :band

  delegate :company_name, to: :client, prefix: :client
  delegate :company_email, to: :client, prefix: :client
  delegate :official_website, to: :client, prefix: :client

  def self.approve_user(users_id)
    users = User.friendly.where("slug in(?)", users_id)
    users.each do |user|
      user.update_attributes(approve_status: 1)
    end
  end

end
