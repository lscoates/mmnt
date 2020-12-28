require "rails_helper"

describe Moment, "associations" do
  it { is_expected.to belong_to(:track) }
end

describe Moment, "validations" do
  it { should validate_presence_of(:track) }
  it { should validate_presence_of(:body) }
end

describe Moment, "callbacks" do
  describe "#set_original_date" do
    it "sets the original_date when nil" do
      moment = build(:moment, original_date: nil)
      expect { moment.save! }.to change { moment.original_date }.from(nil)
    end

    it "does not overwrite the original_date when it's present" do
      original_date = Time.zone.parse("Jan 1 2020, 10:00am")
      moment = create(:moment, original_date: original_date)
      expect(moment.original_date).to eql(original_date)
    end
  end
end

