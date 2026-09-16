require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    let(:attrs) do
      {
        email: "asd@qwe.com",
        name: "Test Activity",
        password: "123456",
        password_confirmation: "123456"
      }
    end
    subject{ described_class.new(attrs) }

    it "is invalid if :name is bigger than 128 chars" do
      attrs[:name] = "X"*129
      expect(subject.valid?).to eq(false)
    end

    it "is invalid with no :email" do
      attrs.delete(:email)
      expect(subject.valid?).to eq(false)
    end

    it "is invalid without :password" do
      attrs.delete(:password)
      expect(subject.valid?).to eq(false)
    end

    it "is invalid with different :password_confirmation" do
      attrs[:password_confirmation] = "456456"
      expect(subject.valid?).to eq(false)
    end

    it "is valid with the right attrs" do
      expect(subject.valid?).to eq(true)
    end
  end
end
