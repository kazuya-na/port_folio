class Public::DiariesController < ApplicationController
  def create
    @diary = Diary.new(diary_params)
    @diary.end_user_id = current_end_user.id
    if @diary.date.present? && @diary.save
       flash[:notice] = '日誌に記録しました。'
       redirect_to diary_path(@diary)
    else
      @diaries = Diary.where(end_user_id: current_end_user.id)
      @diary_new = Diary.new
      render 'index'
    end
  end

  def index
    @diary_new = Diary.new
    @diaries = Diary.where(end_user_id: current_end_user.id).order(created_at: :desc)
  end

  def show
    @diary = Diary.find(params[:id])
  end

  def edit
    @diary = Diary.find(params[:id])
  end

  def update
    @diary = Diary.find(params[:id])
    if @diary.update(diary_params)
      flash[:notice] = '日誌を更新しました。'
      redirect_to diary_path(@diary.id)
    else
      render :edit
    end
  end

  def destroy
    diary = Diary.find(params[:id])
    diary.destroy
    flash[:alert] = '日誌を削除しました。'
    redirect_to request.referer
  end

  private

  def diary_params
    params.require(:diary).permit(:end_user_id, :date, :dbp, :sbp, :bt, :weight, :exercise)
  end
end
