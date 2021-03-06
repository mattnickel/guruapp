# frozen_string_literal: true

class Ability
      include CanCan::Ability
    
      def initialize(user)
        user ||= User.new # guest user (not logged in)
        if user.admin?
              can :manage, :all
              can :access, :all 
              can :access, :rails_admin       # allow admin users to access Rails Admin
              can :manage, :dashboard
              can :manage, :pages            
        end
        
        if user.employee?
              can :manage, User
              can :manage, Video
              can :manage, Viewing
              can :manage, SocialPost
              can :manage, Category
              can :access, :rails_admin   # allow employees to access Rails Admin
              can :manage, :dashboard
              can :manage, :pages
              can :manage, :comments
        end
    
        if user.coach?
              can :manage, User
              can :manage, :dashboard
        end
    
        if user.standard?
              can :manage, SocialPosts
              can :manage, User
              can :access, :videos
        end
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
      end
    end
    