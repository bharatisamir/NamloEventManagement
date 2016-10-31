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

    def initialize(user)

      #alias_action :create, :read, :update, :destroy, :to => :crud
      alias_action :update, :destroy, :to => :modify
      alias_action :complete, :read, :update, :destroy, :to => :crud

      user ||= User.new


      if user.role?(:admin)
        can :manage, :all

      elsif user.role?(:host)
        can :create, Event
        can :modify, Event do |event|
          event.Host.user_id == user.id
        end

        can :crud, Quotation do |quote|
          quote.Event.Host.user_id == user.id
        end

      elsif user.role?(:service_provider)
        can :read, Event
        can :read, Quotation

      else
        can :create, ToDoList
        can :crud, ToDoList do |to_do_list|
          to_do_list.user_id == user.id
        end

      end

=begin
      if user.role?(:admin)
        can :manage, :all

      else

        can :crud, ToDoList do |to_do_list|
          to_do_list.user_id == user.id
        end


        can :crcd, ToDoItem do |to_do_item|
          to_do_item.user_id == user.id
        end

        can :read, :all
        can :cud, Quotation do |quote|
          @event = Event.find(quote.event_id)
          @host = Host.find(@event.host_id)
          @host.user_id == user
        end




      end
=end



=begin
      if user.role?(:host)
        can :create, Event
        can :manage, Event do |event|
          event.user_id == user.id
        end
      end

      if user.role?(:service_provider)
        can :create, Event
        can :manage, Event do |event|
          event.user_id == user.id
        end
      end
=end

    end


  end
end
