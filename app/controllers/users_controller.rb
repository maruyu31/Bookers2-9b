class UsersController < ApplicationController
  before_action :ensure_correct_user, only:[:edit, :update]

  def index
    @users = User.all
    @new_book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @new_book = Book.new
    if params[:created_at] == ""
      @book_count = "日付を入力してください"
    else
      created_at = params[:created_at]
      @book_count = @books.where(["created_at LIKE?", "#{created_at}%"]).count
    end
    # @today_books = @user.books.where(created_at: Date.today.all_day).count
    # @yesterday_books = @user.books.where(created_at: 1.day.ago.all_day).count
    # @weekly_books = @user.books.where(created_at: 1.week.ago.all_week(start_day = Date.beginning_of_week)).count
    # @last_week_books = @user.books.where(created_at: 2.week.ago.all_week(start_day = Date.beginning_of_week)).count
  end

  #searchで書く場合の書き方
  # def search
  #   @user = User.find(params[:user_id])
  #   @books = @user.books
  #   @book = Book.new
  #   if params[:created_at] == ""
  #     @search_book = "日付を選択してください"
  #   else
  #     create_at = params[:created_at]
  #     @search_book = @books.where(['created_at LIKE ? ', "#{create_at}%"]).count
  #   end
  # end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully"
    else
      render :edit
    end
  end

  def follows
    @user = User.find(params[:id])
    @users = @user.follows
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end

  def compare_day

  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
