class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    before_action :require_admin, only: [:destroy]
    
    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end
    
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] =  @user.id
            flash[:success] = "#{@user.username}の登録が成功しました"
            # サインアップしたらそのままログイン状態に飛ぶ
            redirect_to user_path(@user)
        else
            render 'new'
        end
    end
    
    def edit
    end
    
    def update
        if @user.update(user_params)
            flash[:success] = "アカウントが正常にアップデートされました"
            redirect_to articles_path
        else
            render 'edit'
        end
    end
    
    def show
        # クリックしたさいに固有のidが引数部分に入り@userに代入される?
        @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end
    
    def destroy
        @user = User.find(params[:id])
        flash[:danger] = "ユーザーに関連する全ての情報が削除されました"
        redirect_to users_path
    end
    
    private
    
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
    
    def set_user
        @user = User.find(params[:id])
    end
    
    def require_same_user
        if current_user != @user and !current_user.admin?
            flash[:danger] = "自分のアカウントのみ編集ができます"
            redirect_to root_path
        end
    end
    
    def require_admin
        if logged_in? and !current_user.admin?
            flash[:danger] = "管理人のみが実行できます"
            redirect_to root_path
        end
    end
end