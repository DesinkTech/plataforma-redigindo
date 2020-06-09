class CorrectionCommentsController < ApplicationController
  before_action :require_login
  before_action :set_correction_comment, only: [:destroy]

  def destroy
    if @correction_comment.destroy
        redirect_to start_correction_path(@correction_comment.correction.hash_id)
    end
  end

  private

  def set_correction_comment
    @correction_comment = CorrectionComment.find_by(id: params[:id]) 
  end
end
