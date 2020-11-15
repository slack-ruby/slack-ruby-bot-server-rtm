# frozen_string_literal: true

require 'spec_helper'

describe SlackRubyBotServer::RealTime::Server do
  let(:logger) { subject.send :logger }
  let(:team) { Team.new(token: 'token') }
  context 'with options' do
    subject do
      SlackRubyBotServer::RealTime::Server.new(
        team: team,
        aliases: %w[foo bar]
      )
    end
    before do
      allow(subject).to receive(:sleep)
      allow(logger).to receive(:error)
    end
    it 'sets token' do
      expect(subject.send(:client).token).to eq 'token'
    end
    it 'sets aliases' do
      expect(subject.send(:client).aliases).to eq %w[foo bar]
      expect(subject.send(:client).names).to include 'foo'
    end
  end
  context 'start_server!' do
    pending 'starts server'
    pending 'handles account_inactive'
    pending 'handles invalid_auth'
    pending 'handles generic error'
  end
end
