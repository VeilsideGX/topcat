class Client < ActiveRecord::Base
  belongs_to :user
  validates :company_name, :company_email, :official_website, :country_id, :zip, presence: true
  after_create :assign_role

  protected

  def assign_role
    user = self.user
    user.user_type = 3
    user.save
  end

end
