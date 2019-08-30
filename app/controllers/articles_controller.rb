class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end
  
  def create
    # viewに表示するだけの行
    render plain: params[:article].inspect
    #  生成した記事を保存する処理を行う
    @article = Article.new(article_params)
    @article.save
    # 生成した記事を view に飛ばす
    redirect_to article_show(@article)
  end
  
  private
    # このメソッドからarticleが作成される。
    def article_params
      params.require(:article).permit(:title, :description)
    end
end
