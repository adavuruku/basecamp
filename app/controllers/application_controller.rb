class ApplicationController < ActionController::Base
    private
    def verifyLogin
      @_verifuUser ||= session[:authid] &&
        User.find_by(userid: session[:authid]) 
    end
end
