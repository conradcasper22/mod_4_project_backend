class Api::V1::UsersController < ApplicationController


    def index
        @users = Users.all
        render json: @users.to_json( include: [:cohorts])
    end

    def show
        @user = User.find_by(id: params[:id])
        render json: @user.to_json( include: [:cohorts])
    end

    def new
        
    end

    def create
        @user = User.create(username: params[:username], password: params[:password])
        if @user.valid?
            render json: {user: @user}, status: :created
        else
            render json: { error: 'failed to create user' }, status: :not_acceptable
        end
    end

    def edit
        @user = User.find_by(id: user_params[:id])
        render json: @user
    end

    def update
        @user = User.find_by(id: params[:id])
        @user.username = user_params[:username]
        @user.bio = user_params[:bio]
        @user.avatar = user_params[:avatar]
        @user.location = user_params[:location]
        @user.name = user_params[:name]
        @user.project_1 = user_params[:project_1]
        @user.project_2 = user_params[:project_2]
        @user.email = user_params[:email]
        @user.github = user_params[:github]
        @user.linkedIn = user_params[:linkedIn]
        @user.twitter = user_params[:twitter]
        @user.facebook = user_params[:facebook]
        @user.save
        flash[:success] = "User Updated Successfully!"
        redirect_to `/api/v1/users/#{@user.id}`
    end

    def delete
        user = User.find_by(id: params[:id])
        user.destroy
        flash[:warning] = “Instance Successfully Deleted!”
        redirect_to `/api/v1/users`
    end


    private

    def user_params
        require.(:user).permit(
            :username,
            :password,
            :bio,
            :avatar,
            :location,
            :name,
            :project_1,
            :project_2,
            :email,
            :github,
            :linkedIn,
            :twitter,
            :facebook
        )
    end




end