# frozen_string_literal: true

require 'test_helper'

class OrchestratorTest < Minitest::Test
  def test_override_devise_notification
    user = User.new
    assert_equal "Send the email_changed notification", user.send_devise_notification('email_changed')

    orchestrator = Evento::Orchestrator.new(User)
    orchestrator.override_devise_notification do |notification, *devise_params|
      "Beep Beep!"
    end

    assert_equal "Beep Beep!", user.send_devise_notification('email_changed')
  end

  def test_define_event_methods_from_state_machine_on_test_event_handler
    test_klass = Class.new do
      def stop(comment)
        "I do not care for the comment #{comment}, Goodbye!"
      end
    end

    orchestrator = Evento::Orchestrator.new(Car)
    orchestrator.define_event_methods_on(test_klass, state_machine: true) do |comment|
      "The comment is #{comment}"
    end

    test_handler = test_klass.new
    assert_equal %i[drive start stop], test_handler.public_methods(false).sort
    assert_equal 'The comment is Hello', test_handler.start('Hello')
    assert_equal 'The comment is Faster', test_handler.drive('Faster')
    assert_equal 'I do not care for the comment Bye!, Goodbye!', test_handler.stop('Bye!')
  end

  def test_after_audit_trail_commit
    orchestrator = Evento::Orchestrator.new(Car)
    orchestrator.after_audit_trail_commit(:transitions) do |resource_state_transition|
      car = resource_state_transition.resource
      car.started += 1 if event == 'start'
      car.driven  += 1 if event == 'drive'
      car.stopped += 1 if event == 'stop'
      car.save!
    end

    car = Car.create!(model: 'Renault Modus', colour: 'Red')
    assert_equal({ started: 0, driven: 0, stopped: 0 }, car.stats)

    car.start!
    assert_equal({ started: 1, driven: 0, stopped: 0 }, car.stats)

    car.drive!
    assert_equal({ started: 1, driven: 1, stopped: 0 }, car.stats)

    car.stop!
    assert_equal({ started: 1, driven: 1, stopped: 1 }, car.stats)

    car.start!
    assert_equal({ started: 2, driven: 1, stopped: 1 }, car.stats)
  end

  def test_after_audit_trail_commit_with_named_audit_trail
    orchestrator = Evento::Orchestrator.new(Bicycle, audit_trail_name: :movements)
    orchestrator.after_audit_trail_commit(:transitions) do |resource_state_transition|
      bike = resource_state_transition.vehicle
      bike.cycles += 1 if %w[kick_off brake].include?(event)
      bike.save!
    end

    bike = Bicycle.create!(model: 'Sprinter', colour: 'Blue')
    assert_equal 0, bike.cycles

    bike.kick_off!
    assert_equal 1, bike.cycles

    bike.brake!
    assert_equal 2, bike.cycles
  end

  def test_after_transaction_log_commit
    orchestrator = Evento::Orchestrator.new(Scooter)
    orchestrator.after_transaction_log_commit(:transitions) do |transaction_log_entry|
      scooter = transaction_log_entry.transaction_loggable
      event   = transaction_log_entry.event

      if event.present?
        scooter.started += 1 if event == 'start'
        scooter.driven  += 1 if event == 'drive'
        scooter.stopped += 1 if event == 'stop'
        scooter.save!
      end
    end

    scooter = Scooter.create!(model: 'Puch', colour: 'Blue')
    assert_equal({ started: 0, driven: 0, stopped: 0 }, scooter.stats)

    scooter.start!
    assert_equal({ started: 1, driven: 0, stopped: 0 }, scooter.stats)

    scooter.drive!
    assert_equal({ started: 1, driven: 1, stopped: 0 }, scooter.stats)

    scooter.stop!
    assert_equal({ started: 1, driven: 1, stopped: 1 }, scooter.stats)

    scooter.start!
    assert_equal({ started: 2, driven: 1, stopped: 1 }, scooter.stats)
  end

end
