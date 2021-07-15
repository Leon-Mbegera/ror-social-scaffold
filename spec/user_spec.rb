require 'rails_helper'

RSpec.describe User, type: :model do

  context "User validity" do

    it "should have valid attributes" do
      first_user = User.create(name: "Bonnie", email: "bonnie@example.com", password: "123456")
      expect(first_user.valid?).to be true
    end
  end
end