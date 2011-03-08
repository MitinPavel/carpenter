class User
  attr_accessor :email, :first_name, :address

  def save!
  end
end

class Address
  attr_accessor :zipcode
end

class UserBuilder
  include Carpenter::ActiveRecordBuilder
  contains :email, :first_name, :address

  def build
    @product = User.new
    @product.first_name = @first_name
    @product.address = @address

    @product
  end
end
