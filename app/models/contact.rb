class Contact < ActiveRecord::Base
  belongs_to :todo, required: false

end
