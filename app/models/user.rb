class User < ApplicationRecord
    has_many :project
    has_one_attached :passport
    before_save { 
        self.email = email.downcase
    }
    has_secure_password
    self.primary_key = "userid"
    validates :authorname, presence: true
    validates :phone, :email, presence: true
    validates :phone, numericality: {only_integer: true}, length: {is: 11 , message: "length should be 11"}
    validates :userid, presence: true, uniqueness:true
    validates :password, presence: true, length: { minimum: 6 } , on: :create #oncreate because password field has no value in my table
    validates_confirmation_of :password,  on: :create
    #validates_presence_of :password_confirmation
    validates :contactAdd, presence: true
    validates :right, presence: true
    validates :login, presence: true

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
     
end
