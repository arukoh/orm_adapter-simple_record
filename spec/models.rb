class User < SimpleRecord::Base
  has_strings :name
  has_strings :rating
end

class Note < SimpleRecord::Base
  has_strings :body
  belongs_to :owner, :class_name => "User"
end
