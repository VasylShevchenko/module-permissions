module Recoverable
  extend ActiveSupport::Concern

  def set_reset_password
    raw, enc = Devise.token_generator.generate(self.class, :reset_password_token)

    self.reset_password_token = enc
    self.reset_password_sent_at = Time.now.utc
    self.save(validate: false)

    raw
  end

  def do_reset_password
    clear_reset_password
    set_reset_password
  end

  def clear_reset_password
    self.reset_password_count = nil
    self.reset_password_code = nil
    self.reset_password_token = nil
    self.reset_password_sent_at = nil
  end

  module ClassMethods
    def find_by_unencrypted_reset_password(password_token)
      enc = Devise.token_generator.digest(self.class, :reset_password_token,
                                          password_token)
      find_by_reset_password_token enc
    end
  end


end
