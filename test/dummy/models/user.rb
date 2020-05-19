# frozen_string_literal: true

class User < ActiveRecord::Base
  state_machine initial: :active do
    audit_trail class: ResourceStateTransition, as: :resource

    event :disable do
      transition active: :disabled
    end

    event :enable do
      transition disabled: :active
    end
  end

  def send_devise_notification(notification, *devise_params)
    "Send the #{notification} notification"
  end
end
