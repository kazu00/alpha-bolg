class ArticlesController < ApplicationController
    # only とかかれたメソッドのみメソッド実行直後に set_article が実行される
    before_action :set_article, only: [:edit, :update, :show, :destroy]
    before_action :require_user, except: [:index, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    
    def index
        @articles = Article.paginate(page: params[:page], per_page: 5)
    end
    
    def new
          @article = Article.new
    end
    
    def edit
    end
    
    def create
        #  titleとdescriptionのみを許可したメソッドを引数としている
        @article = Article.new(article_params)
        @article.user = current_user
        if @article.save
          flash[:success] = "記事の作成に成功しました"
          # 生成した記事を view に飛ばす
          redirect_to article_path(@article)
        else
          render  'new'
        end
    end
    
    def update
    if @article.update(article_params)
        flash[:danger] = "記事の更新に成功しました"
        redirect_to article_path(@article)
    else
        render 'edit'
    end
    end
    
    def show
    end
    
    def destroy
        @article.destroy
        flash[:notice] = "記事の削除に成功しました"
        # 特定の記事を削除した後、一覧に戻る
        redirect_to article_path
    end

    private
    
    # 特定のarticleを検索する
    # よく出るメソッドなのでbefore_actionで実行した
    def set_article
        @article = Article.find(params[:id])
    end

    # articleを作成するときtitleとdescriptionのみ許可する
    def article_params
        params.require(:article).permit(:title, :description)
    end
    
    def require_same_user
        if current_user != @article.user
           flash[:danger] = "you can only edit or delete your own article"
           redirect_to root_path
        end
    end
end


