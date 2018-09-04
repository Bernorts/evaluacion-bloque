class Interview < ApplicationRecord
  has_many :evaluations, :dependent => :destroy
end


