# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Tenejo::VirusScanner, :virus_scan do
  subject(:scanner) { described_class.new(file) }
  let(:file)        { Tempfile.new('not_a_virus') }

  it 'is false for a normal file' do
    expect(scanner).not_to be_infected
  end

  context 'when a file is infected' do
    let(:file) { File.open("#{fixture_path}/virus_check.txt") }

    after do
      file.close
    end

    it 'is true' do
      expect(scanner).to be_infected
    end
  end
end
