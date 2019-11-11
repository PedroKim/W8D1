class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?

    def login(user)
        session[:session_token] = user.reset_session_token!
    end

    def current_user
        return nil unless session[:session_token]
        current_token = session[:session_token]
        @current_user ||= User.find_by(session_token: current_token)
    end

    def logged_in?
        !!current_user
    end

    def ensure_logged_in
        unless logged_in?
            flash[:errors] = ["You need to be signed in."]
            redirect_to new_session_url 
        end
    end


end
