# frozen_string_literal: true

RSpec.describe LatestVersion do
  describe '.call' do
    context "ruby" do
      it "returns a valid version" do
        expect(described_class.call('ruby')).to match(/\A\d+\.\d+\.\d+\z/)
      end
    end
  end
end
