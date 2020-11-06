class UsersController < ApplicationController
  # deviseにはユーザーの詳細ページについての設定がデフォルトでない為、自分でコントローラーを作成し設定する
  def show
    @user = User.find(params[:id])
  end
end
