# frozen_string_literal: true

RSpec.describe LatestVersion do
  it "has a version number" do
    expect(LatestVersion::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
