# frozen_string_literal: true
class UserAbility
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can [:index, :show], User
    can [:create, :update], User, user_id: user.id
  end
end
