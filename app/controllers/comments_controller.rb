class CommentsController < ApplicationController
  load_and_authorize_resource
  #before_filter :redirect_unless_admin, :except => [:index, :create]
  layout false
  def index
    @event = Event.find(params[:event_id]) if params[:event_id]
    @comments = @event ? @event.comments.paginate(:page => params[:page]) : Comment.paginate(:page => params[:page])
    @comment = Comment.new
    @guest = Guest.find(params[:guest_id]) if params[:guest_id]
    respond_to do |format|
      format.html
    end
  end

  def create
    @comment = Comment.new(params[:comment])
    respond_to do |format|
      if @comment.save
        format.html { redirect_to :back, notice: 'Thanks for your comment!' }
        format.js { render json: @comment, status: :created }
      else
        format.html { redirect_to :back, notice: 'Error, comment was not created' }
        format.js { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
       @comment = Comment.find(params[:id])
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.js
    end
  end
end
