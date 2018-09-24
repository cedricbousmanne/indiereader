Warden::Strategies.add(:password) do
  def valid?
    session['token']
  end

  def authenticate!
    u = User.find_by(token: session['token'])
    if u
      success!(u)
    else
      u.regenerate_token
      fail!("Could not log in")
    end
  end
end