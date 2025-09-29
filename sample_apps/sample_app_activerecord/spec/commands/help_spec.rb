# frozen_string_literal: true

require 'spec_helper'
require 'commands/help'

describe Help do
  let!(:team) { Fabricate(:team) }
  let(:app) { SlackRubyBotServer::RealTime::Server.new(team: team) }
  let(:client) { app.send(:client) }
  let(:message_hook) { SlackRubyBot::Hooks::Message.new }

  it 'default' do
    expect(client).to receive(:say).with(channel: 'channel', text: [Help::HELP, SlackRubyBotServer::INFO].join("\n"))
    expect(client).to receive(:say).with(channel: 'channel')
    message_hook.call(client, Hashie::Mash.new(channel: 'channel', text: "#{SlackRubyBot.config.user} help"))
  end
end
