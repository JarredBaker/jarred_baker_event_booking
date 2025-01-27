# frozen_string_literal: true
class TicketAbility
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can [:index, :show, :create, :new], Ticket, user_id: user.id
  end
end
