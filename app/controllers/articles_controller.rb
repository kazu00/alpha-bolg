class ArticlesController < ApplicationController

  def index
    @articles = Articles.all
  end

  def new
    @article = Article.new
  end
  
  def edit
    # edit.htmlから情報を受け取る？
    @article = Article.find(params[:id ])
    if @article.update(article_params)
      flash[:notice] = "記事の編集に成功しました"
      # 受け取った@articleをshow.htmlで表示する
      redirect_to article_path(@article)
    else
      # edit.htmファイルを表示する
      render 'edit'
    end
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
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "記事の削除に成功しました"
    # 特定の記事を削除した後、一覧に戻る
    redirect_to article_path
  end
  
  private
    # このメソッドからarticleが作成される。
    def article_params
      params.require(:article).permit(:title, :description)
    end
end
