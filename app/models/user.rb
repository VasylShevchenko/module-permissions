class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  include Recoverable
  include Trackable

  validates :email,
            presence: true,
            uniqueness: true

  has_one :auth_token, dependent: :destroy
  belongs_to :role, optional: true


  after_create :create_auth_token

  def user_token
    begin
      auth_token.token if defined?(auth_token)
    rescue
      create_auth_token
      auth_token.token if defined?(auth_token)
    end
  end

  def get_full_list_permissions
    user_permissions = permissions
    const_permissions = PERMISSIONS.deep_dup

    const_permissions.each { |k, v| const_permissions[k] = user_permissions[k.to_s] || v }
  end
end
