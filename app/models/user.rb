class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :timeoutable, :confirmable

  has_many :invoices
  has_paper_trail
  attr_writer :login


  after_initialize :set_default_role

  # only allow letter, number, underscore and punctuation for username
  validates_format_of :username, with: /^[a-zA-Z_ \.]*$/, :multiline => true
  

  validates :phonenum, presence: true, uniqueness: true, numericality: { only_integer: true }, length: { is: 10 }

  validates :email, presence: true, uniqueness: true

  validates :username, presence: true, uniqueness: true
 
  def login
    @login || self.username || self.email || self.phonenum
  end

  def admin?
    return self.admin == true
  end

  def self.find_for_database_authentication(warden_conditions)
        conditions = warden_conditions.dup
        if (login = conditions.delete(:login))
          where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
        elsif conditions.has_key?(:username) || conditions.has_key?(:email)
          where(conditions.to_h).first
        end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  private

  def set_default_role
    self.admin ||= false
  end

end
