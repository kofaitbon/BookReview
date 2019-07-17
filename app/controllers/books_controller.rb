class BooksController < ApplicationController
before_action :find_book, only: [:show, :edit, :update, :destroy]
before_action :set_categories, only: [:new, :create, :edit, :update]


def index
    if params[:category].blank?
        @books = Book.all.order(created_at: :desc)
    else
        @category_id = Category.find_by(name: params[:category]).id
        @books = Book.where(:category_id => @category_id).order("created_at DESC")
    end
 end


 def show
 end

 def new
    @book = current_user.books.build
 end

 def create
    @book = current_user.books.build(book_params)
    @book.category_id = params[:category_id]

    if @book.save
        flash[:notice] = "保存しました"
        redirect_to root_path
    else
        flash[:notice] = "保存出来ませんでした"
        render 'new'
    end
 end

 def edit
 end   

 def update
    if @book.update(book_params)
        redirect_to book_path(@book)
    else
        render'edit'
    end
 end

 def destroy
    @book.destroy
    redirect_to root_path
 end

 private
    def book_params
        params.require(:book).permit(:title, :description, :author, :category_id, :book_img)
    end

    def find_book
        @book = Book.find(params[:id])
    end

    def set_categories
        @categories = Category.all.map{ |c| [c.name, c.id] }    
    end
end
