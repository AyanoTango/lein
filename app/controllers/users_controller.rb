class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  protect_from_forgery :except => [:create]

  # GET /users
  # GET /users.json
  def index #ユーザー一覧ページ
    #@users = User.all
   @users = User.all
   render json: @users
 end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    render json: @user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json #ユーザー登録ページで追加ボタンを押した時　３
  def create
    params[:user] = params
    @user = User.new(user_params) #←送られてきたparamsで直接newしてもいい
    if @user.save
      puts "登録完了"
      # $loginUser = user.id
      # redirect_to rooms_url #ルーム一覧へ移動
      signUp = { "status" => "ok"}
      render json: signUp
    else
      puts "既に登録されたIDです"
      #同じページを再表示
      signUp = { "status" => "error"}
      render json: signUp
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # ログインユーザーを保存しておく
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name_id, :password, :name)
    end


end
