require 'rails_helper'

RSpec.describe User do
  describe "validations" do
    subject { described_class.new(attrs) }

    let(:attrs) do
      {
        email: "asd@qwe.com",
        name: "Test Activity",
        password: "123456",
        password_confirmation: "123456",
      }
    end

    it "is invalid if :name is bigger than 128 chars" do
      attrs[:name] = "X"*129
      expect(subject.valid?).to be(false)
    end

    it "is invalid with no :email" do
      attrs.delete(:email)
      expect(subject.valid?).to be(false)
    end

    it "is invalid without :password" do
      attrs.delete(:password)
      expect(subject.valid?).to be(false)
    end

    it "is invalid with different :password_confirmation" do
      attrs[:password_confirmation] = "456456"
      expect(subject.valid?).to be(false)
    end

    it "is valid with the right attrs" do
      expect(subject.valid?).to be(true)
    end
  end
end
