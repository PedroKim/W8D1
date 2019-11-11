class SubsController < ApplicationController
    before_action :ensure_user_is_moderator, only: [:edit, :update]

    def ensure_user_is_moderator
        @sub = Sub.find(params[:id])
        unless current_user.id == @sub.moderator_id
            flash[:errors] = ["You are not the moderator."]
            redirect_to sub_url(params[:id])
        end
    end

    def index
        @subs = Sub.all

        render :index
    end

    def show
        @sub = Sub.find(params[:id])
        @posts = @sub.posts

        render :show
    end

    def new
        @sub = Sub.new

        render :new
    end

    def create
        @sub = Sub.new(sub_params)
        @sub.moderator_id = current_user.id

        if @sub.save
            flash[:success] = "Sub successfully created."
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :new, status: 422
        end
    end

    def edit
        @sub = Sub.find(params[:id])

        render :edit
    end

    def update
        @sub = Sub.find(params[:id])

        if @sub.update_attributes(sub_params)
            flash[:success] = "Sub successfully updated."
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :edit, status: 422
        end
    end

    private
    def sub_params
        params.require(:sub).permit(:title, :description)
    end
end