class Article < ApplicationRecord
    validates   :title, presence: true, length: { minimum: 3, maximum: 50 }
    validates   :description, presence: ture, length: { minimum: 10, maximum: 300 }
end