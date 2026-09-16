require 'rails_helper'

RSpec.describe ActivityHit, type: :model do
  describe "validations" do
    let(:date) { DateTime.now }
    let(:activity) { create :activity }
    let(:attrs) { {date: date, activity: activity} }
    subject{ described_class.new(attrs) }

    it "is invalid without :activity" do
      attrs.delete(:activity)
      expect(subject.valid?).to eq(false)
    end

    it "is invalid without :date" do
      attrs.delete(:date)
      expect(subject.valid?).to eq(false)
    end

    it "is valid with the right attrs" do
      expect(subject.valid?).to eq(true)
    end
  end

  describe ".today" do
    let(:todays_hit) { create :activity_hit }
    before(:each) do
      todays_hit
      create :activity_hit, date: 1.day.ago
      create :activity_hit, date: 2.days.ago
    end
    subject { described_class.today.map(&:id) }

    it "returns hits today" do
      expect(subject).to eq([todays_hit.id])
    end
  end

  describe ".this_month" do
    let(:todays_hit) { create :activity_hit }
    before(:each) do
      todays_hit
      create :activity_hit, date: 1.month.ago
      create :activity_hit, date: 2.months.ago
    end
    subject { described_class.this_month.map(&:id) }

    it "returns hits for this month" do
      expect(subject).to eq([todays_hit.id])
    end
  end

  describe ".past_month" do
    let(:past_month_hit) { create :activity_hit, date: 1.month.ago }
    before(:each) do
      create :activity_hit # Today
      past_month_hit
      create :activity_hit, date: 2.months.ago
    end
    subject { described_class.past_month.map(&:id) }

    it "returns hits for past month" do
      expect(subject).to eq([past_month_hit.id])
    end
  end

  describe ".recent" do
    let(:recent) { create :activity_hit, date: 7.hours.ago }
    before(:each) do
      recent
      create :activity_hit, date: 9.hours.ago
      create :activity_hit, date: 12.hours.ago
    end
    subject { described_class.recent.map(&:id) }

    it "returns hits for past 8 hours" do
      expect(subject).to eq([recent.id])
    end
  end

end
