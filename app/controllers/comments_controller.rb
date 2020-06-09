class CommentsController < ApplicationController
  before_action :require_login, :require_admin
  before_action :set_comment, only: [:edit, :update]

  def new
    @comment = Comment.new
    @comment.competence_id = params[:competence]
  end
  
  def create
    @comment = Comment.new(comment_params)

    
    if @comment.save
      redirect_to competence_path(@comment.competence.category.id,@comment.competence), success: "Comentário criado com sucesso"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to competence_path(@comment.competence.category.id,@comment.competence), success: "Comentário alterado com sucesso"
    else
      render :edit
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:description, :competence_id)
  end

  def set_comment
    @comment = Comment.find_by(id: params[:id])
  end

  def competence_options
    @competence_options = Competence.all.pluck(:description, :id)
  end
end
