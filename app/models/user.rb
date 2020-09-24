class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  EMAIL_REGEX = /.+@.+/.freeze
  validates_format_of :email, with: EMAIL_REGEX
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]{6,}\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX

  has_one_attached :image
  has_many :questions
  has_many :requests
  has_many :answers
  has_many :user_characteristics
  has_many :characteristics, through: :user_characteristics
  has_many :comments
  has_many :posts
  has_many :favorites
  has_many :favorites_posts, through: :favorites, source: :post 
  

  
end
