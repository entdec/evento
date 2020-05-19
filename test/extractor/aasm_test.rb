# frozen_string_literal: true

require 'test_helper'

class ExtractorAasmTest < Minitest::Test
  def test_without_options_extracts_nothing_from_test_aasm
    extractor = Evento::Extractor.new(TestAASM)
    assert_equal [], extractor.extract_events
  end

  def test_with_state_machine_option_extracts_aasm_events_from_test_aasm
    extractor = Evento::Extractor.new(TestAASM)
    assert_equal %w[run stop walk], extractor.extract_events(state_machine: true)
  end

  def test_with_devise_option_extracts_devise_events_from_test_aasm
    extractor = Evento::Extractor.new(TestAASM)
    assert_equal ['confirmation_instructions',
                  'email_changed',
                  'password_change',
                  'reset_password_instructions',
                  'unlock_instructions'], extractor.extract_events(devise: true)
  end

  def test_with_both_options_extracts_devise_and_aasm_events_from_test_aasm
    extractor = Evento::Extractor.new(TestAASM)
    assert_equal ['confirmation_instructions',
                  'email_changed',
                  'password_change',
                  'reset_password_instructions',
                  'run',
                  'stop',
                  'unlock_instructions',
                  'walk'], extractor.extract_events(devise: true, state_machine: true)
  end
end
