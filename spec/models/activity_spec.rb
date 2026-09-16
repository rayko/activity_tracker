require 'rails_helper'

RSpec.describe Activity, type: :model do
  describe "validations" do
    let(:user) { create :user }
    let(:attrs) { {name: "Test Activity", user: user} }
    subject{ described_class.new(attrs) }

    it "is invalid without :name" do
      attrs.delete(:name)
      expect(subject.valid?).to eq(false)
    end

    it "is invalid without :user" do
      attrs.delete(:user)
      expect(subject.valid?).to eq(false)
    end

    it "is invalid if :name already exists" do
      create :activity, name: attrs[:name], user: user
      expect(subject.valid?).to eq(false)
    end

    it "is valid with the right fields" do
      expect(subject.valid?).to eq(true)
    end
  end
end
