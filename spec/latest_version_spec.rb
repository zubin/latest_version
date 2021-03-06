# frozen_string_literal: true

RSpec.describe LatestVersion do
  describe '.of' do
    LatestVersion.supported_libraries.map(&:to_s).each do |library_name|
      context library_name do
        it "returns a MAJOR.MINOR.PATCH version" do
          VCR.use_cassette("of-#{library_name}") do
            expect(described_class.of(library_name)).to match(/\A\d+\.\d+\.\d+(\.\d+)?\z/)
          end
        end
      end
    end

    context "unknown" do
      it "raises an error" do
        expect { described_class.of('unknown') }.to raise_error(described_class::UnknownLibraryError, 'unknown')
      end
    end
  end

  describe '.of_rubygem' do
    context "rails" do
      it "returns latest version" do
        VCR.use_cassette('of_rubygem-rails') do
          expect(described_class.of_rubygem('rails')).to eq(described_class.of('rails'))
        end
      end
    end
  end
end
