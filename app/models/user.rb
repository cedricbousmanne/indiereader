class User < ApplicationRecord
  has_secure_token
  after_create :regenerate_token
  
  def generate_random_state_string
    random_state_string = (0...8).map { (65 + rand(26)).chr }.join
    self.update_attribute :last_state_string, random_state_string
    random_state_string
  rescue ActiveRecord::RecordNotUnique
    retry
  end

  
  def regenerate_token
    new_token = (0...50).map { (65 + rand(26)).chr }.join
    self.update_attribute :token, new_token
    new_token
  rescue ActiveRecord::RecordNotUnique
    retry
  end


end
