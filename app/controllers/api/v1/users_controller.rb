class Api::V1::UsersController < ApplicationController
    def create
        user = User.create(user_params)
        if user.save
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
