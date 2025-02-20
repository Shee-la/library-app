require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:one)  # Assuming fixtures exist
  end

  test "should get index" do
    get books_url
    assert_response :success
  end

  test "should create book" do
    assert_difference("Book.count", 1) do
      post books_url, params: { book: { title: "New Book", author: "New Author", status: "available" } }
    end
  
    assert_redirected_to books_url
    follow_redirect!
    
    # Check flash notice instead of response.body
    assert_equal "Book added successfully!", flash[:notice]
  end
  

  test "should show book" do
    get book_url(@book)
    assert_response :success
  end
   

 
end
