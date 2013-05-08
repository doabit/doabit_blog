class Account < ActiveRecord::Base
  attr_accessor :password, :password_confirmation

  has_many :comments, :dependent => :destroy
  has_many :posts

  # Validations
  validates_presence_of     :email, :role,               :if => :native_login_required
  validates_presence_of     :password,                   :if => :native_login_required
  validates_presence_of     :password_confirmation,      :if => :native_login_required
  validates_length_of       :password, :within => 4..40, :if => :native_login_required
  validates_confirmation_of :password,                   :if => :native_login_required
  validates_length_of       :email,    :within => 3..100,:if => :native_login_required
  validates_uniqueness_of   :email,    :case_sensitive => false,:if => :native_login_required
  validates_format_of       :email,    :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,:if => :native_login_required
  validates_format_of       :role,     :with => /[A-Za-z]/

  # Callbacks
  before_save :encrypt_password, :if => :password_required

  ##
  # This method is for authentication purpose
  #
  def self.authenticate(email, password)
    account = first(:conditions => { :email => email }) if email.present?
    account && account.has_password?(password) ? account : nil
  end

  def has_password?(password)
    ::BCrypt::Password.new(crypted_password) == password
  end


   def self.create_with_omniauth(auth)
    create! do |account|
      account.provider = auth["provider"]
      account.uid      = auth["uid"]
      account.name     = auth[:info]["nickname"]
      # account.email    = auth["user_info"]["email"] if auth["user_info"] # we get this only from FB
      account.role     = "commenter"
    end
  end

  private
  def encrypt_password
    self.crypted_password = ::BCrypt::Password.create(password) if native_login_required
  end

  def password_required
    crypted_password.blank? || password.present?
  end


  def native_login_required
    provider.blank? && password_required
  end

end
