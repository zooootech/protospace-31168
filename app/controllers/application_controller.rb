class ApplicationController < ActionController::Base
  # ifオプションの値にメソッド名を指定することで、その戻り値がtrueであったときにのみ処理を実行するよう設定する
  # :devise_controller?というdeviseのヘルパーメソッド名を指定して、もしdeviseに関するコントローラーの処理であれば、そのときだけconfigure_permitted_parametersメソッドを実行するように設定
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  # deviseにおけるストロングパラメーターを設定（自分で新しく追加したカラムに対して）し、パラメーターを取得
  def configure_permitted_parameters
    # devise_parameter_sanitizer.permit(:deviseの処理名, keys: [:許可するキー])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile, :position, :occupation])
  end
end
