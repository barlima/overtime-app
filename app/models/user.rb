class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PHONE_REGEX = /\A[0-9]*\z/

  validates_presence_of :first_name, :last_name, :phone
  validates_format_of :phone, with: PHONE_REGEX
  validates :phone, length: { is: 10 }

  has_many :posts
  has_many :audit_logs

  def full_name
    last_name.upcase + ", " + first_name.upcase
  end
end
