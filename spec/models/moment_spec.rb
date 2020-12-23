require "rails_helper"

describe Moment, "associations" do
  it { is_expected.to belong_to(:track) }
end

describe Moment, "validations" do
  it { should validate_presence_of(:track) }
  it { should validate_presence_of(:body) }
end

