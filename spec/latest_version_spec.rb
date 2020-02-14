# frozen_string_literal: true

RSpec.describe LatestVersion do
  describe '.call', :vcr do
    around do |example|
      VCR.use_cassette(cassette) { example.run }
    end

    let(:cassette) { self.class.parent_groups.first.name[/[^:]+$/, 0] }

    context "ruby" do
      it "returns a valid version" do
        expect(described_class.call('ruby')).to match(/\A\d+\.\d+\.\d+\z/)
      end
    end
  end
end
