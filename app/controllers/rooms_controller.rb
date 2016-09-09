class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  # GET /rooms
  # GET /rooms.json # ユーザー一覧ページ　７
  def index
    login_user = User.find(1)#テスト用
    #login_user = User.find_by(access_token: 'c423128bad02e42be0a721cc54fa2614')#テスト用
    @loginUserRelationship = Relationship.where(user_id: login_user)

    friendRoom = {}
    @loginUserRelationship.each do |friendship|
      room = Room.find_by(id: friendship.room_id)
      friendRoom.store(room.id, room.room_name)
    end
    render json: friendRoom
    #room_nameから「丹後彩乃＆」を消したjsonを渡す
  end

  # GET /rooms/1
  # GET /rooms/1.json #チャットルーム内のコメント　６
  # 指定したroom_idを持つコメントを全て表示
  def show
    @room = Room.find(params[:id])
    @comments = Comment.where(room_id: @room.id)

    render json: @comments.to_json

  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json　＃ユーザーをタップしてルーム作成時、友達になる時　４
  def create
    login_user = User.find(1)#テスト用
    #login_user = User.find_by(access_token: 'c423128bad02e42be0a721cc54fa2614')#テスト用
    partner = User.find(params[:user_id])

    @relationship = Relationship.new(user_id: params[:user_id],room_id: (Room.count)+1)
    #↑タップしたuser_idと一番新しいroom_idでrelationship作成
    @loginUserRelationship = Relationship.new(:user_id =>login_user.id , :room_id => @relationship.room_id)
    #↑ログインuserと先ほど作ったrelationship と同じromm_idでrelationship作成
    @room = Room.new(room_name: login_user.name + '&' + partner.name)
    #↑「ログインuserの名前＆話相手の名前」をroom.room_nameに保存

      loginUserRelationship = Relationship.where(user_id: login_user.id)
      #ログインユーザーのrelationshipの中のroomId全部

      loginUserRelationship.each do |value|
        a1 = Relationship.where(room_id: value.room_id)#全てのRからログインユーザーのroom_idと同じidを持つRを代入
        a2 = a1.where.not(user_id: login_user.id )#その中からログインユーザー以外のRを代入
        a2.each do |tolkUserR|#ログインユーザー以外のRを回して
          if tolkUserR.user_id == params[:user_id]
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


  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:user_id1, :user_id2)
    end
end
