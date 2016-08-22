class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :pictures

  validates :username, length: { in: 3..20 }
  validates_presence_of :username
  validates_format_of :username, with: /\A[a-zA-Z0-9_]*\z/

  validates :email, email: true

  def admin?
    role && role == 'admin'
  end
end
