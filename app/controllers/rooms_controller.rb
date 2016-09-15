class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  # GET /rooms
  # GET /rooms.json
  def index

  end

  # GET /rooms/1
  # GET /rooms/1.json #チャットルーム内のコメント　６
  # 指定したroom_idを持つコメントを全て表示
  def show
    @room = Room.find(params[:id])
    @comments = Comment.where(room_id: @room.id)

    #roomsがない場合はno_commentを返す
    # if @comments.empty?
    #   @comments = @comments.create(:comment =>"no_comment",:user_id =>"no_comment",:room_id =>"no_comment",:created_at =>"no_comment",:updated_at =>"no_comment")
    #   render json: @comments.to_json
    #   puts("*********")
    #   return
    # end
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
  # POST /rooms.json　＃ユーザー一覧ページ　７
  def create
    login_user = User.find_by(access_token: params[:access_token])
    @loginUserRelationship = Relationship.where(user_id: login_user.id)

    friendRoom = {}
    @loginUserRelationship.each do |friendship|
      room = Room.find_by(id: friendship.room_id)
      friendRoom.store(room.id, room.room_name)
      puts(friendRoom[0].class)
    end
    render json: friendRoom

    #room_nameから「丹後彩乃＆」を消したjsonを渡す
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
