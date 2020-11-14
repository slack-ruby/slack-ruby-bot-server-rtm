# frozen_string_literal: true

require 'spec_helper'

describe SlackRubyBotServer::Config do
  let(:team) { Fabricate(:team) }
  context 'with defaults' do
    let(:server) { SlackRubyBotServer::RealTime::Server.new(team: team) }
    let(:services) { SlackRubyBotServer::Service.instance.instance_variable_get(:@services) }
    before do
      allow(SlackRubyBotServer::RealTime::Server).to receive(:new).with(team: team).and_return(server)
      allow(server).to receive(:stop!)
    end
    it 'starts a team' do
      expect(server).to receive(:start_async)
      SlackRubyBotServer::Service.instance.start!(team)
    end
    context 'started team' do
      before do
        allow(server).to receive(:start_async)
        SlackRubyBotServer::Service.instance.start!(team)
      end
      it 'assigns team server' do
        expect(team.server).to_not be nil
      end
      it 'removes team server' do
        SlackRubyBotServer::Service.instance.stop!(team)
        expect(team.server).to be nil
      end
      it 'deactivates a team' do
        SlackRubyBotServer::Service.instance.deactivate!(team)
        expect(team.server).to be nil
      end
    end
  end
  context 'overriding server_class' do
    let(:server_class) do
      Class.new(SlackRubyBotServer::RealTime::Server) do
        attr_reader :called

        def initialize(options = {})
          @called = true
          super
        end
      end
    end
    before do
      SlackRubyBotServer::RealTime.configure do |config|
        config.server_class = server_class
      end
    end
    after do
      SlackRubyBotServer::RealTime.config.reset!
    end
    it 'creates an instance of server class' do
      expect(server_class).to receive(:new).with(team: team).and_call_original
      allow_any_instance_of(server_class).to receive(:start_async)
      allow_any_instance_of(server_class).to receive(:stop!)
      SlackRubyBotServer::Service.instance.start!(team)
      SlackRubyBotServer::Service.instance.stop!(team)
    end
  end
end
