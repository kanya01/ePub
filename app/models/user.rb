class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
          :confirmable, :trackable

  # Role constants
  READER = 0
  AUTHOR = 1
  EDITOR = 2
  ADMIN = 3

  ROLES = {
    reader: READER,
    author: AUTHOR,
    editor: EDITOR,
    admin: ADMIN
  }.freeze
  # enum role, { reader: 0, author: 1, editor: 2, admin: 3 }


  # Validations
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, inclusion: { in: ROLES.values }

  before_validation :mark_as_confirmed
  before_validation :set_default_role, on: :create

  def mark_as_confirmed
    self.confirmation_token = nil
    self.confirmed_at = Time.now
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  # Role methods
  def reader?
    role == READER
  end

  def author?
    role == AUTHOR
  end

  def editor?
    role == EDITOR
  end

  def admin?
    role == ADMIN
  end

  private

  def set_default_role
    self.role ||= READER
  end

end