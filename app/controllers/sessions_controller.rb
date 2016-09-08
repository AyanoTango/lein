class SessionsController < ApplicationController
  protect_from_forgery :except => [:create]
  protect_from_forgery :except => [:destroy]

  def index
    print("****************")
    print(session[:user_id])
    print("****************")
  end

  def new
  end

  # ログインする
  def create
    user = User.find_by(name_id: params[:name_id])
    print("user begin")
    puts(user)
    print("user end")
    print(user.authenticate(user[:password]))

    if user && user.authenticate(params[:password])
    # if user && user.authenticate(user[:password]) ##エラー
      #if user != 'false' ##エラー
      session[:user_id] = user.id
      print("login\n")
    else ###  ID,パスが異なった時###
      redirect_to root_url
      print("different\n")
    end

    print("****************\n")
    print(session[:user_id])
    print("\n****************\n")
  end


  #authenticate:引数とUserが一致しないとfalseを返す


  # def create
  #   user = User.find_by(name_id: params[:name_id], password: params[:password])
  #   #session[:user_id] = user.id
  #
  #   print("****************")
  #   print(session[:user_id])
  #   print("****************")
  # end

  # DELEAT /logout #ログアウトボタンを押した時
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
