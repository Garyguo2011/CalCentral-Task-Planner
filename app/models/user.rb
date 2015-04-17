class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
  					:first_name, :last_name, :email_notifications
  # attr_accessible :title, :body
  validates :email, :uniqueness => true
  has_many :tasks
  def full_name
  	first_name + " " + last_name
  end

  def email_config
    if self.email_notifications == nil || self.email_notifications == "hourly"
      return 60.minutes
    end
    if self.email_notifications == "daily"
      return 1.day
    end
  end

  def self.test_mail
    @user = User.all
    @user.each do |u|
      UserMailer.task_confirmation(u).deliver
    end
    return "success"
  end
end
