# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'evento'
require 'i18n'
require 'active_record'
require 'pry'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
ActiveRecord::Schema.define do
  ActiveRecord::Schema.verbose = false

  create_table 'animals' do |t|
    t.string 'breed'
    t.string 'name'
    t.string 'state'
  end

  create_table 'bicycles' do |t|
    t.string 'model'
    t.string 'colour'
    t.string 'state'
    t.integer 'cycles', default: 0
  end

  create_table 'cars' do |t|
    t.string 'model'
    t.string 'colour'
    t.string 'state'
    t.integer 'started', default: 0
    t.integer 'driven', default: 0
    t.integer 'stopped', default: 0
  end

  create_table 'scooters' do |t|
    t.string 'model'
    t.string 'colour'
    t.string 'state'
    t.integer 'started', default: 0
    t.integer 'driven', default: 0
    t.integer 'stopped', default: 0
  end

  create_table 'users' do |t|
    t.string 'email'
    t.string 'state'
  end

  create_table 'movements', force: :cascade do |t|
    t.string 'vehicle_type'
    t.integer 'vehicle_id'
    t.string 'namespace'
    t.string 'event'
    t.string 'from'
    t.string 'to'
    t.json 'context'
    t.datetime 'created_at'
  end

  create_table 'resource_state_transitions', force: :cascade do |t|
    t.string 'resource_type'
    t.integer 'resource_id'
    t.string 'namespace'
    t.string 'event'
    t.string 'from'
    t.string 'to'
    t.json 'context'
    t.datetime 'created_at'
  end

  create_table 'transaction_log_entries', force: :cascade do |t|
    t.string 'transaction_loggable_type'
    t.integer 'transaction_loggable_id'
    t.string 'event'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end
end

require 'state_machines-activerecord'
require 'state_machines-audit_trail'
require_relative 'dummy/models/movement'
require_relative 'dummy/models/resource_state_transition'
require_relative 'dummy/models/transaction_log_entry'
require_relative 'dummy/models/animal'
require_relative 'dummy/models/bicycle'
require_relative 'dummy/models/car'
require_relative 'dummy/models/scooter'
require_relative 'dummy/models/user'
require_relative 'dummy/lib/test_aasm'
require_relative 'dummy/lib/test_state_machines'

I18n.backend.store_translations(:en, { devise: { mailer: {
                                  confirmation_instructions: { subject: 'Confirmation instructions' },
                                  reset_password_instructions: { subject: 'Reset password instructions' },
                                  unlock_instructions: { subject: 'Unlock instructions' },
                                  email_changed: { subject: 'Email Changed' },
                                  password_change: { subject: 'Password Changed' }
                                } } })

require 'minitest/autorun'
