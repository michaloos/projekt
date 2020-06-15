class Post < ApplicationRecord
  belongs_to :user_blog
  belongs_to :location
  has_many :comments
  has_and_belongs_to_many :categories
  has_secure_password validations: false
  validates_length_of :password_digest, maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED

  def public?
    password_digest.nil?
  end

  has_attached_file :image, :styles => { :medium =>"1000x1000>", :thumb => "300x300>", :large => "500x500>" }
  validates_attachment_content_type :image,:content_type => /\Aimage\/.*\Z/

end
