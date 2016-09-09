class RelationshipsController < ApplicationController
  before_action :set_relationship, only: [:show, :edit, :update, :destroy]

  # GET /relationships
  # GET /relationships.json
  def index
    @relationships = Relationship.all
  end

  # GET /relationships/1
  # GET /relationships/1.json # チャットルームからお友達一覧ページへ戻るボタンを押した時、７
  def show
    login_user = User.find(1)#テスト用
    #login_user = User.find_by(access_token: 'c423128bad02e42be0a721cc54fa2614')#テスト用

    @relationships = Relationship.where(user_id: login_user)
    render json: @relationships.to_json #遷移後にrelationship のroom-idを一覧で表示し、/room/1　の形で並べる
  end

  # GET /relationships/new
  def new
    @relationship = Relationship.new
  end

  # GET /relationships/1/edit
  def edit
  end

  # POST /relationships　＃ユーザーをタップしてルーム作成時、友達になる時　４
  def create
    login_user = User.find(1)#テスト用
    #login_user = User.find_by(access_token: 'c423128bad02e42be0a721cc54fa2614')#テスト用

    @relationship = Relationship.new(user_id: relationship_params[:user_id],room_id: (Room.count)+1)
    #↑タップしたuser_idと一番新しいroom_idでrelationship作成
    @loginUserRelationship = Relationship.new(:user_id =>login_user.id , :room_id => @relationship.room_id)
    #↑ログインuserと先ほど作ったrelationship と同じromm_idでrelationship作成
    @room = Room.new

      loginUserRelationship = Relationship.where(user_id: login_user.id)
      #ログインユーザーのrelationshipの中のroomId全部

      loginUserRelationship.each do |value|
        a1 = Relationship.where(room_id: value.room_id)#全てのRからログインユーザーのroom_idと同じidを持つRを代入
        a2 = a1.where.not(user_id: login_user.id )#その中からログインユーザー以外のRを代入
        a2.each do |tolkUserR|#ログインユーザー以外のRを回して
          if tolkUserR.user_id == relationship_params[:user_id]
              #ログインユーザー以外のRのuser_idと今回タップしたuser_idと等しいかどうか
            puts("************")
            puts "既に作成済みのRelationshipです"
            puts("************")
            render json: a2.to_json #→　room_id を取り出し　/room/2 へ遷移する
            return
          else　

          end
        end
      end
      #等しくなければ作成
      @relationship.save
      @loginUserRelationship.save
      @room.save
      puts("************")
      puts "Relationship 作成完了"
      puts("************")
      render json: @relationship.to_json #→　room_id を取り出し　/room/2 へ遷移する
  end

  # PATCH/PUT /relationships/1
  # PATCH/PUT /relationships/1.json
  def update
    respond_to do |format|
      if @relationship.update(relationship_params)
        format.html { redirect_to @relationship, notice: 'Relationship was successfully updated.' }
        format.json { render :show, status: :ok, location: @relationship }
      else
        format.html { render :edit }
        format.json { render json: @relationship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /relationships/1
  # DELETE /relationships/1.json
  def destroy
    @relationship.destroy
    respond_to do |format|
      format.html { redirect_to relationships_url, notice: 'Relationship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_relationship
      @relationship = Relationship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def relationship_params
      params.require(:relationship).permit(:room_id, :user_id)
    end
end
