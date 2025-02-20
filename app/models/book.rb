class Book < ApplicationRecord
    has_many :borrowings, dependent: :destroy
  
    validates :title, presence: true, uniqueness: { case_sensitive: false }
    validates :author, presence: true
    validates :status, inclusion: { in: %w[available borrowed] }
  end
  