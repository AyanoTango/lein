class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  protect_from_forgery :except => [:create]

  # GET /comments
  # GET /comments.json
  def index
    #@comments = Comment.all
    @comments = Comment.all
    render json: @comments

    puts("****************")
    puts(session[:user_id])
    puts("****************")
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])
    render json: @comment
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # rooms#show =>
  def view
    @comments1 = Comments.find_by(room_id: params[:room_id], user_id: params[:user_id1])
    render json: @comments1
  end

  # POST /comments
  # POST /comments.json テスト用
  # def create
  #   @comment = Comment.create(comment_params)
  # end
    # @comment = Comment.new(comment_params)

  #   respond_to do |format|
  #     if @comment.save
  #       format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
  #       format.json { render :show, status: :created, location: @comment }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @comment.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # POST /comments
  # POST /comments.json チャットルームで送信ボタンを押した時（room_idとコメントを受け取る）５
  def create
    login_user = User.find(1)#テスト用
    #login_user = User.find_by(access_token: 'c423128bad02e42be0a721cc54fa2614')#テスト用
    @comment = Comment.create(:comment => params[:comment], :user_id => login_user.id, :room_id => params[:room_id])

    render json: @comment.to_json

  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      puts("HOGEHGOEHG")
      puts(params[:id])
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.permit(:comment, :user_id, :room_id)
    end
end
