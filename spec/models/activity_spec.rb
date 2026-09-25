require 'rails_helper'

RSpec.describe Activity do
  describe "validations" do
    subject { described_class.new(attrs) }

    let(:user) { create :user }
    let(:attrs) { { name: "Test Activity", user: user } }

    it "is invalid without :name" do
      attrs.delete(:name)
      expect(subject.valid?).to be(false)
    end

    it "is invalid without :user" do
      attrs.delete(:user)
      expect(subject.valid?).to be(false)
    end

    it "is invalid if :name already exists" do
      create :activity, name: attrs[:name], user: user
      expect(subject.valid?).to be(false)
    end

    context "with other user with same activity name" do
      before do
        usr = create :user
        usr.activities.create! name: attrs[:name]
      end
      
      it "does not collide" do
        expect(subject.valid?).to be(true)
      end
    end

    it "is valid with the right fields" do
      expect(subject.valid?).to be(true)
    end
  end
end
