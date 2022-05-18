# frozen_string_literal: true

# CRUD Articles
class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except: [:index, :show]

  # GET /articles or /articles.json
  def index
    renderer = ::IntroRenderer.new(prettify: true, hard_wrap: true)
    @markdown = markdown(renderer)
    @articles = Article.all.order(published_at: :desc)
  end

  # GET /articles/1 or /articles/1.json
  def show
    renderer = FullRenderer.new(prettify: true, hard_wrap: true)
    @markdown = markdown(renderer)
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit; end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: t("notice.create.success", record: "Article") }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: t("notice.update.success", record: "Article") }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: t("notice.destroy.success", record: "Article") }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = if params[:id]
                 Article.find(params[:id])
               else
                 Article.where(slug: params[:slug]).first
               end
  end

  def markdown(renderer)
    @markdown = Redcarpet::Markdown.new(
      renderer,
      autolink: true,
      tables: true,
      no_intra_emphasis: true
    )
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.fetch(:article, {}).permit(:title, :content)
  end
end
