# frozen_string_literal: true

require 'spec_helper'

describe SlackRubyBotServer::RealTime do
  it 'has a version' do
    expect(SlackRubyBotServer::RealTime::VERSION).not_to be_nil
  end
end
