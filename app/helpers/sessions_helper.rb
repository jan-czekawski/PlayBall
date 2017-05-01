module SessionsHelper
  def logged_in?
    # TODO: switch double negation
    !!current_user
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?("remember", cookies[:remember_token])
        session[:user_id] = user.id
        @current_user = user
      end
    end
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def page_location
    session[:forward_url] = request.original_url if request.get?
  end

  def friendly_redirect_or(default)
    redirect_to(session[:forward_url] || default)
    session.delete(:forward_url)
  end
end
