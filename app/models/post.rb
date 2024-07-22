class Post < ApplicationRecord
    belogns_to :user
    ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.irregular 'post', 'posts'
end
end
