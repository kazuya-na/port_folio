class Public::DiariesController < ApplicationController
  def create
    @diary = Diary.new(diary_params)
    @diary.end_user_id = current_end_user.id
    if @diary.save
       redirect_to diary_path(@diary), notice: "You have created book successfully."
    else
      @diaries = Diary.all
      render 'index'
    end
  end

  def index
    @diary_new = Diary.new
    @diaries = Diary.all
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
      redirect_to diary_path(@diary.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def diary_params
    params.require(:diary).permit(:end_user_id, :date, :bp, :dbp, :sbp, :bt, :weight, :exercise)
  end
end
