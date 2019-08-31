class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end
  
  def create    
    #  記事の作成、titleとdescriptionが入力されている
    @article = Article.new(article_params)
    # =>保存が成功すれば、
    if @article.save
      flash[:notice] = "記事の作成に成功しました"
      # 生成した記事を view に飛ばす
      redirect_to article_path(@article)
    else
      render  'new'
    end
  end
  
  def show
    # 特定の記事を検索する
    @article = Article.find(params[:id])
  end
  
  private
    # このメソッドからarticleが作成される。
    def article_params
      params.require(:article).permit(:title, :description)
    end
end
