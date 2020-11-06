class Comment < ApplicationRecord
  # userおよびprototypeに対するアソシエーションを設定
  belongs_to :user
  belongs_to :prototype
  # バリデーションを設定し、保存する情報に制限をかける
  validates :text, presence: true
end