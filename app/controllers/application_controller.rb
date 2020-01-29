class ApplicationController < ActionController::Base
    before_action :verifyLogin
    private
    def verifyLogin
      if session[:authid] == nil || User.find_by(userid: session[:authid]) ==nil
        flash[:error] ="You have to Login To Access Resource !"
        redirect_to loginPage_path
      end
    end
end
