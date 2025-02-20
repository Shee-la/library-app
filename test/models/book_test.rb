require "test_helper"

class BookTest < ActiveSupport::TestCase
  test "should not save book without a title" do
    book = Book.new(author: "Unknown Author", status: "available")
    assert_not book.save, "Saved the book without a title"
  end

  test "should not save book without an author" do
    book = Book.new(title: "Untitled Book", status: "available")
    assert_not book.save, "Saved the book without an author"
  end

  test "should not allow duplicate book titles" do
    book1 = Book.create(title: "Unique Title", author: "Author One", status: "available")
    book2 = Book.new(title: "Unique Title", author: "Author Two", status: "available")

    assert_not book2.save, "Saved a book with a duplicate title"
  end

  test "should save book with valid attributes" do
    book = Book.new(title: "Valid Book", author: "Valid Author", status: "available")
    assert book.save, "Failed to save a valid book"
  end
end
