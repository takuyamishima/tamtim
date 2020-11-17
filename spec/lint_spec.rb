# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Lint' do
  it 'FactoryBotのLint対象ファイルがLintをパスすること' do
    factories_to_lint = FactoryBot.factories
    FactoryBot.lint factories_to_lint, traits: true
  end
end
