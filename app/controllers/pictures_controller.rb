class PicturesController < ApplicationController
  before_action :set_picture, only: %i[ show edit update destroy ]
  # skip_before_action :login_required, only: [:new, :create]


  def index
    @pictures = Picture.all
  end

  def new
    @picture = Picture.new
  end

  def edit
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    respond_to do |format|
      if @picture.save
        format.html { redirect_to @picture, notice: "Picture was successfully created." }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: "Picture was successfully updated." }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: "Picture was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_picture
      @picture = Picture.find(params[:id])
    end

    def ensure_correct_user
      @picture = Picture.find(params[:id])
      if @picture.user_id != current_user.id
        flash[:notice] = "No authority"
        redirect_to pictures_url
      end
    end

    def picture_params
      params.require(:picture).permit(:image,:image_cache, :content, :user_id)
    end
end
