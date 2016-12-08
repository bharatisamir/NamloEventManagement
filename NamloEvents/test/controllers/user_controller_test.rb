require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest

  def setup
    @ability = Object.new
    @ability.extend(CanCan::Ability)
  end


  test "render index if have read ability on survey" do
    @ability.can :read, Survey
    get surveys_url
    assert_template :index
  end

  test "render index if have read ability on invitation" do
    @ability.can :read, Invitation
    get invitations_url
    assert_template :index
  end















end
