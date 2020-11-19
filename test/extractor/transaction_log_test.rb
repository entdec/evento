# frozen_string_literal: true

require 'test_helper'

class TransactionLogTest < Minitest::Test
  def test_active_record_with_transaction_log_entries_association
    extractor   = Evento::Extractor.new(Scooter)
    association = extractor.extract_transaction_log_association
    assert_equal TransactionLogEntry, association
  end

  def test_active_record_without_transaction_log_entries_association
    extractor   = Evento::Extractor.new(Bicycle)
    association = extractor.extract_transaction_log_association
    assert_nil association
  end

  def test_non_active_record
    extractor   = Evento::Extractor.new(TestAASM)
    association = extractor.extract_transaction_log_association
    assert_nil association
  end
end
