class Api::V1::UsersController < ApplicationController
    def create
        user = User.create(user_params)
        if user.save
            # UserRepresenter is a representer for cleaner code seen in representers
            # check as_json representer as well on how to format the user when it is saved to the database with a token and this is the json
            # representation we will see on screen.
            # check representers/user_respresenter.rb for more architecture details
            render json: UserRepresenter.new(user).as_json, status: :created
        else
            @user.save
            render json: { error: @user.errors.full_messsages }, status: :unproccessable_entity
        end
    end

    private
    def user_params
        params.require(:user).permit(:username, :password, :password_confirmation)
    end
end
