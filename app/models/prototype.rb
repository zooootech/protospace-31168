class Prototype < ApplicationRecord
  # アソシエーションを設定
  belongs_to :user

=begin Prototypesテーブルの各レコードとActive Storageテーブルの画像ファイルを1対1の関係で紐づけ（アソシエーション）、
       モデルの各レコードは、それぞれ1つのファイルを添付できるようになる
=end
  has_one_attached :image

  # 親モデルを削除した時に、親モデルと関連している子モデルも削除
  has_many :comments, dependent: :destroy
  # バリデーションを設定し、保存する情報に制限をかける
  validates :title, presence: true
  validates :catch_copy, presence: true
  validates :concept, presence: true
  validates :image, presence: true
end
