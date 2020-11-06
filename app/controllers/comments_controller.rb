class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@comment.prototype)
    else
      # 生成されたコメントのprototypeの情報（prototype_id）を変数@prototypeに代入
      @prototype = @comment.prototype
      # 上で指定されたprototypeに紐付けられている全てのコメントを変数@commentsに代入
      @comments = @prototype.comments
      # renderやredirect_toの後には、ルーティングのURLやPrefixを記述することで、そのアクションを実行できる
      render "prototypes/show"
    end
  end

  private

  # ストロングパラメーターをセットし、特定の値のみを受け付けるようにし、且つ、user_idとprototype_idと一緒に保存させる
  # prototype_idカラムは、paramsで渡されるようにするので、params[:prototype_id]として保存
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
