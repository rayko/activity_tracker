require 'rails_helper'

RSpec.describe Activity do
  let(:user) { create :user }

  describe "validations" do
    subject { described_class.new(attrs) }

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

  describe "scopes" do
    let(:active_activity) { create :activity, user: user, archived: false }
    let(:archived_activity) { create :activity, user: user, archived: true }

    describe ".active" do
      subject { user.activities.active }

      before { active_activity; archived_activity }

      it "returns unarchived activities" do
        expect(subject.count).to eq(1)
        expect(subject.take.id).to eq(active_activity.id)
      end
    end

    describe ".archived" do
      subject { user.activities.archived }

      before { active_activity; archived_activity }

      it "returns unarchived activities" do
        expect(subject.count).to eq(1)
        expect(subject.take.id).to eq(archived_activity.id)
      end
    end
  end

  describe "#archive!" do
    let(:activity) { create :activity, user: user, archived: false }

    it "sets :archived to true" do
      activity.archive!
      expect(activity.reload.archived).to be(true)
    end

    it "does not raise error if already archived" do
      activity.archive!
      expect { activity.archive! }.to_not raise_error
    end
  end

  describe "#unarchive!" do
    let(:activity) { create :activity, user: user, archived: true }

    it "sets :archived to false" do
      activity.unarchive!
      expect(activity.reload.archived).to be(false)
    end

    it "does not raise error if already archived" do
      activity.unarchive!
      expect { activity.unarchive! }.to_not raise_error
    end
  end

  describe "#archived?" do
    let(:activity) { create :activity, user: user, archived: false }

    it "returns true if archived" do
      activity.archive!
      expect(activity.reload.archived?).to be(true)
    end

    it "returns false if not archived" do
      activity.unarchive!
      expect(activity.reload.archived).to be(false)
    end
  end
end
