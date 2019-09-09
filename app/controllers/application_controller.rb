class ApplicationController < ActionController::Base
    # applicationcontrollerはユーザーがログインしている状態が確認する
    protect_from_forgery with: :exception
    
    helper_method :current_user, :logged_in?
    
    def current_user
        # ○○であれば、△△する。○○でなければ△△しない。
        # @current_userという箱の中に値がなければ、Modelからデータを引っ張て来て代入するの意味。 or演算子という
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    
    def logged_in?
        # !!は、強制的にオブジェクトを論理値にする。falseになるのははnilとfalseのみ
        !!current_user
    end
    
    def require_user
        if !logged_in?
            flash[:danger] = "実行するにはログインする必要があります"
            redirect_to root_path
        end
    end
end
