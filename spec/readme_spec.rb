# frozen_string_literal: true

require 'climate_control'
require 'open3'

RSpec.describe 'README.md' do
  subject(:readme) { File.read(File.expand_path('../README.md', __dir__)) }

  let(:expected_contents) do
    [
      '```sh',
      '$ latest_version --help',
      help_output,
      '```',
    ].join("\n")
  end

  let(:help_output) { Open3.capture2(executable, '--help').first.strip }
  let(:executable) { File.expand_path('../exe/latest_version', __dir__) }

  it "is up to date" do
    prevent_truncation do
      expect(readme).to include(expected_contents)
    end
  end

  def prevent_truncation
    ClimateControl.modify THOR_COLUMNS: '100' do
      yield
    end
  end
end
