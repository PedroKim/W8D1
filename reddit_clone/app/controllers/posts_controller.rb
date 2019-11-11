class PostsController < ApplicationController
    before_action :ensure_user_is_author, only: [:edit, :update]

    def ensure_user_is_author
        @post = Post.find(params[:id])
        unless current_user.id == @post.author_id
            flash[:errors] = ["You are not the author of this post."]
            redirect_to post_url(params[:id])
        end
    end

    def new
        @post = Post.new
        @subs = Sub.all

        render :new
    end

    def create
        @post = Post.new(post_params)
        @post.author_id = current_user.id
        @subs = Sub.all

        if @post.save
            flash[:success] = "Post successfully created!"
            redirect_to post_url(@post.id)
        else
            flash[:errors] = @post.errors.full_messages
            render :new, status: 422
        end
    end

    def show
        @post = Post.find(params[:id])
        @author = User.find(@post.author_id)
        # @comments = @post.comments.where(parent_comment_id: nil)
        @all_comments = @post.comments.includes(:author)
        render :show
    end

    def edit
        @post = Post.find(params[:id])
        @subs = Sub.all

        render :edit
    end

    def update
        @post = Post.find(params[:id])
        @subs = Sub.all
        
        if @post.update_attributes(post_params)
            flash[:success] = "Post successfully updated!"
            redirect_to post_url(@post.id)
        else
            flash[:errors] = @post.errors.full_messages
            render :edit, status: 422
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        flash[:success] = "Post successfully deleted!"
        redirect_to sub_url(@post.sub_id)
    end

    private
    def post_params
        params.require(:post).permit(:title, :url, :content, sub_ids: [])
    end

end