class ArticlesController < ApplicationController
  

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = current_user.articles.build
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def update
    @article=Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was modified.'
    else
      render :edit
    end
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def authorize_user!
    redirect_to articles_path, alert: 'You are not authorized to edit this article' unless @article.user == current_user
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
