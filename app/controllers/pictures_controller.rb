class PicturesController < ApplicationController
  #アクションが実行される前に、以下のメソッドを実行する。onlyオプションを使用し、指定されたアクションが実行された場合のみbefore_actionが実行される。
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  #indexビューの呼び出し
  def index
  # picturesテーブルの一覧をrailsのallメソッドで取得し、@picturesに格納
  @pictures = Picture.all.order(created_at: :desc)
  end
  #pictureのインスタンスが一つ入っている変数を、ビューに渡す。新しいpictureの作成。newメソッドはインスタンスのみの生成で、レコードをテーブルに保存しない。
  def new
  #form_withに渡す変数を、Picture.newで0から作成。
  @picture = Picture.new
  end
  #createメソッドを使用することで、テーブルにレコードを作成、保存できる。
  def create
  #フォームに記述した内容を送信した場合、parametersという名のハッシュ値に変換して、アプリ内部に送り込む。
  @picture = current_user.pictures.build(picture_params)
  #戻るボタンが実行されたら、
  if params[:back]
  #入力フォームを再描写する。renderメソッドを使用することで、createアクションで呼び出すviewをnew.html.erbに変換できる。
  render :new
  else
  #newメソッドで作成したインスタンスをsaveメソッドを使用し、テーブルに保存する。
  if @picture.save
  #picture投稿時にユーザー宛にメールが送信される。
  PictureMailer.picture_mail(@picture).deliver
  #pictures_pathというPrefixを書くことで、"/pictures"というURLの指定をする。一覧画面へ遷移して、"Pictureを作成しました！"とメッセージを表示する。
  redirect_to pictures_path, notice: "Pictureを作成しました！"
  else
  render :new
  end
  end
  end
  #現在ログインしているユーザのお気に入りのpicture_idを取得し、そのデータをfavoriteインスタンス変数に格納。
  def show
  @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  @user = @picture.user
  end
  #編集
  def edit
  end
  #編集された内容で、データを更新する。
  def update
  #送られてきた内容を、paramsメソッドで取得。引数の値で更新できる。
  if @picture.update(picture_params)
  #値を更新できたらredirectメソッドでindexアクションにリダイレクトさせる。
  redirect_to pictures_path, notice: "Pictureを編集しました！"
  #失敗した場合はeditアクションをrenderする。
  else
  render :edit
  end
  end
  #削除対象の値をインスタンス変数@pictureに取得。destroyメソッドを使用して、削除を実行する。
  def destroy
  #削除を実行した際に、投稿一覧に以下のメッセージを表示する。
  @picture.destroy
  redirect_to pictures_path, notice: "Pictureを削除しました！"
  end
  #バリデーションの際の条件分岐
  def confirm
  @picture = current_user.pictures.build(picture_params)
  #確認画面に移る前に、invalid?メソッドにて、バリデーションを実行させ、失敗したら投稿画面に戻す。
  render :new if @picture.invalid?
  end
  #投稿者のみ編集、削除できるようにensure_correct_userという、現在のuser_idと投稿者のidが一致していないとはじくメソッドを作成。
  def ensure_correct_user
  @picture = Picture.find_by(id: params[:id])
  #Pictureクラスからはuser_idを、Userクラスから作ったcurrent_userからはidを取得し、それが一致しない場合、indexに飛ばす。
  if @picture.user_id != current_user.id
  flash[:notice] = "権限がありません"
  redirect_to("/pictures/index")
  end
  end
  #privateメソッド配下にメソッドを記述すると、そのメソッドはPrivateMethodになり、そのクラスからしか呼び出せないようになる。
  private
  def picture_params
  #セキュリティーのために、予め受け入れるデータを文字列、画像に指定する。pictureキーの、title...のみ取得を許可する。
  params.require(:picture).permit(:title, :content, :image, :image_cache, :remove_image)
  end
  #idをキーとして値を取得するメソッドを追加
  def set_picture
  #編集する内容を入力させる。すでに存在するデータを編集して、再度保存するidを元に、データベースから当該するデータを取得。
  @picture = Picture.find(params[:id])
  end
end
