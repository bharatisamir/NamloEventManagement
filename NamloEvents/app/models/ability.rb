class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities


    user ||= User.new

    if user.role?(:Admin)
      can :manage, :all
    end

    if user.role?(:Service_Provider)

      can :create,ToDoList
      can :manage, ToDoList do |list|
        list.try(:user) == user
      end

      can :read, ToDoList do |list|
        list.try(:user) == user
      end

      can :create,Portfolio
      can :read,Portfolio
      can :manage, Portfolio do |port|
        port.service_provider_id == user.service_provider.id
      end

      can :create, PeerReview
      can :read, PeerReview
      can :manage, PeerReview do |peer|
        peer.reviewer_id.to_i == user.service_provider.id
      end

      can :read, Review
      can :read, Quotation
      can :read, Event, :publish_on_marketplace => true

      can :create, Offer
      can :read, Offer
      can :manage, Offer do |offer|
        offer.service_provider_id.to_i == user.service_provider.id
      end

    end

    if user.role?(:Host)

      can :create,ToDoList
      can :manage, ToDoList do |list|
        list.try(:user) == user
      end

      can :read, ToDoList do |list|
        list.try(:user) == user
      end

      can :create, Review
      can :manage, Review do |review|
       review.reviewer_id.to_i == user.id
      end


      can :read, Reservation

      can :update, Reservation do |reserve|
        @event = Event.find(reserve.event_id)
        @event.host.id == user.host.id
      end

      can :destroy, Reservation do |reserve|
        @event = Event.find(reserve.event_id)
        @event.host.id == user.host.id
      end


      can :create, Quotation
      can :read, Quotation

      can :update, Quotation do |quote|
        @event = Event.find(quote.event_id)
        @event_host = Host.find(@event.host_id)
        @event_host.user_id == user.id
      end

      can :destroy, Quotation do |quote|
        @event = Event.find(quote.event_id)
        @event_host = Host.find(@event.host_id)
        @event_host.user_id == user.id
      end

      can :read, Portfolio
      can :read, Offer

      can :create, Menu

      can :read, Menu do |menu|
        @event = Event.find(menu.event_id)
        @event_host = Host.find(@event.host_id)
        @event_host.user_id == user.id
      end

      can :update, Menu do |menu|
        @event = Event.find(menu.event_id)
        @event_host = Host.find(@event.host_id)
        @event_host.user_id == user.id
      end

      can :destroy, Menu do |menu|
        @event = Event.find(menu.event_id)
        @event_host = Host.find(@event.host_id)
        @event_host.user_id == user.id
      end

      can :create, Invitation

      can :read, Invitation do |invite|
        @event = Event.find(invite.event_id)
        @event_host = Host.find(@event.host_id)
        @event_host.user_id == user.id
      end

      can :update, Invitation do |invite|
        @event = Event.find(invite.event_id)
        @event_host = Host.find(@event.host_id)
        @event_host.user_id == user.id
      end

      can :destroy, Invitation do |invite|
        @event = Event.find(invite.event_id)
        @event_host = Host.find(@event.host_id)
        @event_host.user_id == user.id
      end

      can :create, Income

      can :read, Income do |income|
        @event = Event.find(income.event_id)
        @event_host = Host.find(@event.host_id)
        @event_host.user_id == user.id
      end

      can :update, Income do |income|
        @event = Event.find(income.event_id)
        @event_host = Host.find(@event.host_id)
        @event_host.user_id == user.id
      end

      can :destroy, Income do |income|
        @event = Event.find(income.event_id)
        @event_host = Host.find(@event.host_id)
        @event_host.user_id == user.id
      end

      can :create, GuestList

      can :read, GuestList do |list|
        @event = Event.find(list.event_id)
        @event_host = Host.find(@event.host_id)
        @event_host.user_id == user.id
      end

      can :update, GuestList do |list|
        @event = Event.find(list.event_id)
        @event_host = Host.find(@event.host_id)
        @event_host.user_id == user.id
      end

      can :destroy, GuestList do |destroy|
        @event = Event.find(destroy.event_id)
        @event_host = Host.find(@event.host_id)
        @event_host.user_id == user.id
      end

      can :create, Expense

      can :read, Expense do |expense|
        @event = Event.find(expense.event_id)
        @event_host = Host.find(@event.host_id)
        @event_host.user_id == user.id
      end

      can :update, Expense do |expense|
        @event = Event.find(expense.event_id)
        @event_host = Host.find(@event.host_id)
        @event_host.user_id == user.id
      end

      can :destroy, Expense do |expense|
        @event = Event.find(expense.event_id)
        @event_host = Host.find(@event.host_id)
        @event_host.user_id == user.id
      end

      can :create, Event
      can :manage, Event do |event|
        event.host_id.to_i == user.host.id
      end

      can :create, EventOrder

      can :read, EventOrder do |order|
        @event = Event.find(order.event_id)
        @event.host.id == user.host.id
      end

      can :update, EventOrder do |order|
        @event = Event.find(order.event_id)
        @event.host.id == user.host.id
      end

      can :destroy, EventOrder do |order|
        @event = Event.find(order.event_id)
        @event.host.id == user.host.id
      end


      can :create, Booking

      can :read, Booking do |book|
        @event = Event.find(book.event_id)
        @event.host.id == user.host.id
      end

      can :update,Booking do |book|
        @event = Event.find(book.event_id)
        @event.host.id == user.host.id
      end

      can :destroy, Booking do |book|
        @event = Event.find(book.event_id)
        @event.host.id == user.host.id
      end

    end

    can :read, Invitation
    can :event_detail, Invitation
    can :read, Event
    can :create, Reservation
    can :update, MenuItem
    can :read, Survey




  end




end
