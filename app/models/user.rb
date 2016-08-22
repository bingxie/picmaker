class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :pictures

  validates :username, presence: true,
                       length: { in: 3..20 },
                       uniqueness: { case_sensitive: false },
                       format: { with: /\A[a-zA-Z0-9_]*\z/ }

  validates :email, email: true

  def admin?
    role && role == 'admin'
  end
end
