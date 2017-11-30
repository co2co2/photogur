class PicturesController < ApplicationController
  before_action :ensure_logged_in, except: [:show, :index]
  before_action :load_picture, only: [:show, :edit, :update, :destroy]

  def load_picture
    @picture = Picture.find(params[:id])
  end

  def index

    @pictures = Picture.all
    @most_recent_pictures = Picture.most_recent_five
    @picture_year = Picture.order(created_at: :desc).pluck(:created_at).map { |t| t.year }.uniq!
    @picture_2017 = Picture.created_in_year(2017)

    @all_pictures_by_year = {}
    @picture_year.each do |year|
      pictures = Picture.created_in_year(year)
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


    if @picture.save
      # if the picture gets saved, generate a get request to "/pictures" (the index)
      redirect_to "/pictures"
    else
      # otherwise render new.html.erb
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
      redirect_to "/pictures"
    else
    # otherwise render new.html.erb
      render :new
    end
  end

  def destroy

    @picture.destroy
    redirect_to "/pictures"
  end


end
