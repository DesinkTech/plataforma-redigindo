class CorrectionCommentsController < ApplicationController
  before_action :require_login
  before_action :set_correction_comment

  def update
    @correction_comment.update!(correction_comment_params)
  end

  def destroy
    if @correction_comment.destroy
        # redirect_to start_correction_path(@correction_comment.correction.hash_id)
    end
  end

  private

  def correction_comment_params
    params.require(:correction_comment).permit(:extended_comment, :label_id, :label_coords)
  end

  def set_correction_comment
    @correction_comment = CorrectionComment.find_by(id: params[:id])
  end

end
