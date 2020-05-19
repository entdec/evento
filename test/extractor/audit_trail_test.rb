# frozen_string_literal: true

require 'test_helper'

class AuditTrailTest < Minitest::Test
  def test_active_record_state_machines_with_audit_trail_with_default_association
    extractor   = Evento::Extractor.new(Car)
    association = extractor.extract_audit_trail_association
    assert_equal ResourceStateTransition, association
  end

  def test_active_record_state_machines_with_audit_trail_without_default_assocation
    extractor   = Evento::Extractor.new(Bicycle)
    association = extractor.extract_audit_trail_association
    assert_nil association
  end

  def test_active_record_state_machines_with_audit_trail_with_named_assocation
    extractor   = Evento::Extractor.new(Bicycle)
    association = extractor.extract_audit_trail_association(name: :movements)
    assert_equal Movement, association
  end

  def test_active_record_state_machines_without_audit_trail_with_default_assocation
    extractor   = Evento::Extractor.new(Animal)
    association = extractor.extract_audit_trail_association
    assert_nil association
  end

  def test_active_record_state_machines_without_audit_trail_with_named_assocation
    extractor   = Evento::Extractor.new(Animal)
    association = extractor.extract_audit_trail_association(name: :movements)
    assert_nil association
  end

  def test_non_active_record
    extractor   = Evento::Extractor.new(TestAASM)
    association = extractor.extract_audit_trail_association
    assert_nil association
  end
end
