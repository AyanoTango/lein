class SessionsController < ApplicationController
  # skip_before_filter :verify_authenticity_token
  protect_from_forgery :except => [:index]
  protect_from_forgery :except => [:create]
  protect_from_forgery :except => [:destroy]


  def index
    puts("****************")
    puts(User.find_by(id: session[:user_id]))
    puts("****************")
    @us = User.find_by(id: session[:user_id])
    render json: @us
  end

  def new
  end

  # ログインする　１
  def create
    user = User.find_by(name_id: params[:name_id])

    if user && user.authenticate(params[:password])
       session[:user_id] = user.id
      puts(User.find_by(id: session[:user_id]))
      @us = User.find_by(id: session[:user_id])
      render json: @us
    else

    end
      #room の中からuser_idを持つものだけを表示
    #   $loginUser = user.id
    #   @loginUserRelationships = Relationship.where(user_id: $loginUser)
    #   render json: @loginUserRelationships
    #   puts("login\n")
    # else ###  ID,パスが異なった時###
    #   #redirect_to root_url
    #   puts("different\n")
    # end
    # puts("****************")
    # puts($loginUser)
    # puts("****************")
  end

  # DELEAT /logout #ログアウトボタンを押した時　２
  def destroy
    $loginUser = nil
    #ログイン画面に遷移する
  end

end
