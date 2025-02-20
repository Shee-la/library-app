class BorrowingsController < ApplicationController
  def borrow
    @book = Book.find(params[:id])

    if @book.status == "available"
      @borrowing = Borrowing.create(
        book: @book,
        borrower_name: params[:borrowing][:borrower_name],
        borrowed_at: Time.current  # Save current time correctly
      )
      @book.update(status: "borrowed")
      redirect_to books_path, notice: "Book borrowed successfully!"
    else
      redirect_to books_path, alert: "This book is already borrowed."
    end
  end

  def return_book
    @book = Book.find(params[:id])

    if @book.status == "borrowed"
      last_borrowing = @book.borrowings.where(returned_at: nil).last
      last_borrowing.update(returned_at: Time.current) if last_borrowing

      @book.update(status: "available")
      redirect_to books_path, notice: "Book returned successfully!"
    else
      redirect_to books_path, alert: "This book is already available."
    end
  end

  def history
    @borrower_name = params[:borrower_name]
    @borrowings = Borrowing.where(borrower_name: @borrower_name).order(borrowed_at: :desc)
    render "users_borrowing_history"  # Updated view name
  end
  
end
