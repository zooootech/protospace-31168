class PrototypesController < ApplicationController
  # before_actionでautenticate_user!メソッドを呼び出すことで、アクションを実行する前にそのユーザーがログインしていなければログイン画面に遷移させる
  before_action :authenticate_user!, except: [:index, :show]

  def index
    # indexアクションに、インスタンス変数@prototypesを定義し、すべてのプロトタイプの情報を代入
    # 代入される要素が複数になる為、インスタンス変数を複数形で命名
    @prototypes = Prototype.all
  end

  def new
    # 空のprototypeオブジェクトを生成し、インスタンス変数に代入
    @prototype = Prototype.new
  end

  def create
    # ストロングパラメーターprototype_paramsメソッドを呼び出してオブジェクトを生成
    @prototype = Prototype.new(prototype_params)
    # createアクションにてデータが保存されたときはルートパスに戻る
    if @prototype.save
      redirect_to root_path
    else
    # データが保存されなかったときは新規投稿ページへ戻る
      render :new
    end
  end

  def show
    # findメソッドを使い、特定のレコードの情報を取得
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    # 指定されたprototypeに紐付けられている全てのコメントを変数@commentsに代入
    @comments = @prototype.comments
  end

  def edit
    # Pathパラメータで送信されるID値で、Prototypeモデルの特定のオブジェクトを取得するように記述し、それを@prototypeに代入した
    @prototype = Prototype.find(params[:id])
    # ログインしているユーザーと選択したprototypeの投稿者が一致していない場合
    # 投稿者以外がeditアクションにアクセスしたらトップページにリダイレクトする
    unless current_user == @prototype.user
      redirect_to root_path
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    # ActiveRecordメソッドの一つであるupdateメソッドにより,データが更新された場合
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit
    end
  end

  def destroy
    # プロトタイプを削除し、トップページに戻る
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private

  def prototype_params
=begin 
    prototype投稿時に、ビューから送られてくる情報（title、catch_copy等）に加えて、user_idも一緒に保存したい為、
    current_userメソッドで現在ログインしているユーザー情報を取得し、mergeメソッドで２つのハッシュを一つに統合して保存するストロングパラメーターを設定
=end
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
end
