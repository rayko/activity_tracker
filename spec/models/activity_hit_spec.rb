require 'rails_helper'

RSpec.describe ActivityHit do
  describe "validations" do
    subject { described_class.new(attrs) }

    let(:date) { DateTime.now }
    let(:activity) { create :activity }
    let(:attrs) { { date: date, activity: activity } }

    it "is invalid without :activity" do
      attrs.delete(:activity)
      expect(subject.valid?).to be(false)
    end

    it "is invalid without :date" do
      attrs.delete(:date)
      expect(subject.valid?).to be(false)
    end

    it "is valid with the right attrs" do
      expect(subject.valid?).to be(true)
    end
  end

  describe ".today" do
    subject { described_class.today.map(&:id) }

    let(:todays_hit) { create :activity_hit }

    before do
      todays_hit
      create :activity_hit, date: 1.day.ago
      create :activity_hit, date: 2.days.ago
    end

    it "returns hits today" do
      expect(subject).to eq([ todays_hit.id ])
    end
  end

  describe ".this_month" do
    subject { described_class.this_month.map(&:id) }

    let(:todays_hit) { create :activity_hit }

    before do
      todays_hit
      create :activity_hit, date: 1.month.ago
      create :activity_hit, date: 2.months.ago
    end

    it "returns hits for this month" do
      expect(subject).to eq([ todays_hit.id ])
    end
  end

  describe ".past_month" do
    subject { described_class.past_month.map(&:id) }

    let(:past_month_hit) { create :activity_hit, date: 1.month.ago }

    before do
      create :activity_hit # Today
      past_month_hit
      create :activity_hit, date: 2.months.ago
    end

    it "returns hits for past month" do
      expect(subject).to eq([ past_month_hit.id ])
    end
  end

  describe ".recent" do
    subject { described_class.recent.map(&:id) }

    let(:recent) { create :activity_hit, date: 7.hours.ago }

    before do
      recent
      create :activity_hit, date: 9.hours.ago
      create :activity_hit, date: 12.hours.ago
    end

    it "returns hits for past 8 hours" do
      expect(subject).to eq([ recent.id ])
    end
  end
end
