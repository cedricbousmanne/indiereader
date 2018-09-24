module Authentication  
  module HelperMethods
    def authenticate!
      request.env['warden'].authenticate!
    end

    def current_user
      @current_user ||= User.find(request.env['warden'].user['id'])
    end
  end
end  