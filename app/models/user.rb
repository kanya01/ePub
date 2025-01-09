class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  # Validations
  validates :username, presence: true, uniqueness: { case_sensitive: false },
            format: { with: /\A[a-zA-Z0-9_]+\z/, message: "can only contain letters, numbers, and underscores" }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, inclusion: { in: %w[reader author editor admin] }

  # Virtual attribute for full name
  def full_name
    "#{first_name} #{last_name}"
  end

  # Role checks
  def admin?
    role == 'admin'
  end

  def editor?
    role == 'editor' || admin?
  end

  def author?
    role == 'author' || editor?
  end
  end