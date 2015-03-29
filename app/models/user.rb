class User < ActiveRecord::Base
      has_many:issue
      has_many:comments
      has_secure_password
      validates :username ,presence: true
      validates :username , uniqueness: { case_sensitive: false}

  #添加用户验证
  before_create { generate_token(:auth_token) }

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column =>self[column])
  end
end