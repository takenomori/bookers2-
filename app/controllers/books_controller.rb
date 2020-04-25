# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = 'successfully'
      redirect_to book_path(@book.id)
    else
      flash[:notice] = 'error'
      redirect_to books_path
    end
  end

  def edit
    @book = Book.find(params[:id])
    redirect_to books_path if @book.user_id != current_user.id
  end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = Book.all
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = 'successfully'
      redirect_to book_path(@book.id)
    else
      flash[:notice] = 'error'
      render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :profile_image)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
