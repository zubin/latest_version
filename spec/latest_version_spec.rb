# frozen_string_literal: true

RSpec.describe LatestVersion do
  describe '.call', :vcr do
    around vcr: true do |example|
      VCR.use_cassette(cassette) { example.run }
    end

    let(:cassette) { library_name }
    let(:library_name) { self.class.parent_groups.first.name[/LatestVersion::Call::([^:]+)/, 1].downcase }

    shared_examples "returns a MAJOR.MINOR.PATCH version" do
      specify do
        expect(described_class.call(library_name)).to match(/\A\d+\.\d+\.\d+\z/)
      end
    end

    context "ruby" do
      it_behaves_like "returns a MAJOR.MINOR.PATCH version"
    end
  end
end
