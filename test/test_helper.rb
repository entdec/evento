# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'evento'
require 'i18n'

I18n.backend.store_translations(:en, { devise: { mailer: {
                                  confirmation_instructions: { subject: 'Confirmation instructions' },
                                  reset_password_instructions: { subject: 'Reset password instructions' },
                                  unlock_instructions: { subject: 'Unlock instructions' },
                                  email_changed: { subject: 'Email Changed' },
                                  password_change: { subject: 'Password Changed' }
                                } } })

require 'minitest/autorun'
