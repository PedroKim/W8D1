class CommentsController < ApplicationController

    def new
        @comment = Comment.new
        @post_id = params[:post_id]
        render :new
        # params[:post_id]
    end

    def create
        @comment = Comment.new(comment_params)
        @comment.author_id = current_user.id
        if @comment.save
            flash[:success] = "Comment added!"
            redirect_to post_url(@comment.post_id)
        else
            flash[:errors] = @comment.errors.full_messages
            render :new
        end
    end

    def show
        @comment = Comment.find(params[:id])
        render :show
    end

    private
    def comment_params
        params.require(:comment).permit(:content, :post_id, :parent_comment_id)
    end

end