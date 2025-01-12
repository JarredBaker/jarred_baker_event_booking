# frozen_string_literal: true
class EventAbility
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can [:index, :show], Event
    can [:create, :update, :view_own], Event, user_id: user.id
  end
end
