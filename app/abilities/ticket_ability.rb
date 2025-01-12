# frozen_string_literal: true
class TicketAbility
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can [:index, :show, :create, :update, :destroy], Ticket, user_id: user.id
  end
end
