class User < ApplicationRecord
	has_secure_password
  validates :email, presence: true, uniqueness: true

  before_update :prevent_email_update

  private

  def prevent_email_update
    if email_changed?
      errors.add(:email, "cannot be updated")
      throw(:abort)
    end
  end
end
