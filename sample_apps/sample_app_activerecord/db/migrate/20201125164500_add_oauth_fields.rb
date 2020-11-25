# frozen_string_literal: true

class AddOauthFields < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :oauth_scope, :string
    add_column :teams, :oauth_version, :string, default: 'v1', null: false
  end
end
