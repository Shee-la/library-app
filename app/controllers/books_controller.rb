class BooksController < ApplicationController
    before_action :set_book, only: [:show, :edit, :update, :destroy]
  
    def index
      @books = Book.all
    end
  
    def show
      @book = Book.find(params[:id])
      @borrowings = @book.borrowings.order(borrowed_at: :desc)  # Show history in descending order
      render "show_book_details"
    end
    
  
    def new
      @book = Book.new
      render "books/add_new_book"
    end
  
    def create
      @book = Book.new(book_params)
      @book.status = "available"  # Default status
    
      if @book.save
        redirect_to books_path, notice: "Book added successfully!"
      else
        render "books/add_new_book", status: :unprocessable_entity
      end
    end
  
    def edit
    end
  
    def update
      if @book.update(book_params)
        redirect_to @book, notice: "Book was successfully updated."
      else
        redirect_to @book, alert: "Failed to update book."
      end
    end
    
  
    
    def destroy
      @book = Book.find(params[:id]) # Find the book
      @book.destroy  # Delete the book
    
      flash[:notice] = "Book successfully deleted!"  
      redirect_to books_path  # Redirect back to book list
    end
        
  
    
    private
  
    def set_book
      @book = Book.find(params[:id])
    end
  
    def book_params
      params.require(:book).permit(:title, :author, :status)
    end
  end
  