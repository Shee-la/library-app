Rails.application.routes.draw do
  resources :books do
    member do
      post 'borrow', to: 'borrowings#borrow'   # Calls borrow method in BorrowingsController
      post 'return', to: 'borrowings#return_book'  # Calls return_book method in BorrowingsController
    end
  end

  # Moved borrower history route OUTSIDE the books block
  get 'borrowers/:borrower_name', to: 'borrowings#history', as: 'borrower_history'

  root "books#index"  # Sets homepage to books list
end
