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
        user.update_attribute(:access_token, SecureRandom.hex) #アクセストークン発行

        @loginUserRelationships = Relationship.where(user_id: user.id)#room の中からuser_idを持つものだけを表示
        render json: @loginUserRelationships
        puts("login\n")

      else ###  ID,パスが異なった時###
        #redirect_to root_url
        puts("different\n")
      end
    puts("****************")
    puts(user.id)
    puts(user.access_token)
    puts("****************")

  end

  # DELEAT /logout #ログアウトボタンを押した時　２
  def destroy
    user = User.find_by(access_token: 'c423128bad02e42be0a721cc54fa2614') #テスト用　
    user.update_attribute(:access_token, nil)

    puts("****************")
    puts("logout")
    puts(user.id)
    puts(user.access_token)
    puts("****************")

    #ログイン画面に遷移する
  end

end
