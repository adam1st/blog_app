class ArticlesController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]
  before_filter :set_article, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  skip_before_filter :verify_authenticity_token, :only => [:upvote, :downvote]
  
  def index
    @articles = Article.all
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:success] = "Article has been created"
      redirect_to articles_path
    else
      flash.now[:danger] = "Article has not been created"
      render :new
    end
  end
  
  def edit
    if !current_user.admin?
      flash[:danger] = "You are not an admin"
      redirect_to root_path
    end
  end 
  
  def update
    if !current_user.admin?
      flash[:danger] = "You are not an admin"
      redirect_to root_path
    else
      if @article.update(article_params)
          flash[:success] = "Article has been updated"
          redirect_to @article
      else
        flash.now[:danger] = "Article has not been updated"
        render :edit
      end
    end
  end
        
  def show
    @comment = @article.comments.build
  end 
  
  def destroy
    if @article.destroy
      flash[:success] = "Article has been deleted"
      redirect_to articles_path
    end
  end
  def upvote
    @article.upvote_by current_user
    if @article.vote_registered?
      flash[:success] = "Successfully liked"
      respond_to do |format|
        format.html {redirect_to :back }
        format.json { render json: { count: @article.get_upvotes.size } }
      end
    else
      flash[:danger] = "You have already liked this"
      respond_to do |format|
        format.html {redirect_to :back }
        format.json { head :conflict }
      end
    end
  end
  def downvote
    @article.downvote_by current_user
    if @article.vote_registered?
      flash[:success] = "Successfully disliked"
      respond_to do |format|
        format.html {redirect_to :back }
        format.json { render json: { count: @article.get_downvotes.size } }
     end
    else
      flash[:danger] = "You have already disliked this"
      respond_to do |format|
        format.html {redirect_to :back }
        format.json { head :conflict }
      end
    end
  end
  
  private 
    def article_params
      params.require(:article).permit(:title, :body)
    end
    
    def set_article
    @article=Article.find(params[:id])
    end
end
