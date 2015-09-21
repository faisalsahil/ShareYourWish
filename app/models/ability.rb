class Ability
    include CanCan::Ability

    def initialize(user)
        #alias_action :read, :to => :invite
        @user = user
        @user ||= User.new(:role => 'visitor') # guest user (not logged in)
        send(@user.role)
    end

    def visitor
        can :create, Contribution
        can :create, Feedback
        can :read, :page
        can :read, Post
        can [:manage], Comment, :user_id => @user.id
        can [:invite, :read], Event, :slug => true
        can [:manage], Guest, :guest_id => @user.id
    end    

    def banned
        visitor
        cannot [:create, :destroy], Comment, :user_id => @user.id
    end

    def user
        banned
        can [:manage], Comment, :user_id => @user.id
        can :manage, User, :id => @user.id
        can :manage, Address, :user_id => @user.id
    end

    def tester
        user
        can :manage, Event, :user_id => @user.id
        can :read, :all
    end

    def admin
        can :manage, :all
    end

end
