class PicturesController < ApplicationController
  before_action :ensure_logged_in, except: [:show, :index]
  before_action :load_picture, only: [:show, :edit, :update, :destroy]
  before_action :ensure_user_owns_picture, only: [:edit, :update, :destroy]

  def load_picture
    @picture = Picture.find(params[:id])
  end

  def ensure_user_owns_picture
    unless current_user == @picture.user
      flash[:notice] = "you are not the right user!"
      redirect_to new_session_url
    end
  end

  def index

    @pictures = Picture.all
    @most_recent_pictures = Picture.most_recent_five
    @picture_year = Picture.order(created_at: :desc).pluck(:created_at).map { |t| t.year }.uniq!
    @all_pictures_by_year = {}
    @picture_year.each do |year|
      # pictures = Picture.created_in_year(year)
      @all_pictures_by_year[year] = Picture.created_in_year(year)
    end

    # extract year from the array...
  end

  def show
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new
    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]
    @picture.user_id = current_user.id
    flash[:notice] = "you are not the right user!"


    if @picture.save
      # if the picture gets saved, generate a get request to "/pictures" (the index)
      flash[:notice] = "Upload succeed!"
      redirect_to "/pictures"
    else
      # otherwise render new.html.erb
      flash[:notice] = "upload failed!"
      render :new
    end

  end

  def edit

  end

  def update
    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]
    @picture.user_id = current_user.id
    if @picture.save
    # if the picture gets saved, generate a get request to "/pictures" (the index)
    flash[:notice] = " Update succeed!"
      redirect_to "/pictures"
    else
    # otherwise render new.html.erb
      render :new
    end
  end

  def destroy
    @picture.destroy
    flash[:notice] = " deleted!"
    redirect_to "/pictures"
  end


end
