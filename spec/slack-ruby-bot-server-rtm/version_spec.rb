# frozen_string_literal: true

require 'spec_helper'

describe SlackRubyBotServer::RealTime do
  it 'has a version' do
    expect(SlackRubyBotServer::RealTime::VERSION).to_not be nil
  end
end
