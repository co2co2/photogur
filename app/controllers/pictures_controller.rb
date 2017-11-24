class PicturesController < ApplicationController
  def index
    @pictures = Picture.all
    @most_recent_pictures = Picture.most_recent_five
    @picture_year = Picture.order(created_at: :desc).pluck(:created_at).map { |t| t.year }.uniq!
    

    # extract year from the array...
  end

  def show
    @picture = Picture.find(params[:id])
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new
    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]


    if @picture.save
      # if the picture gets saved, generate a get request to "/pictures" (the index)
      redirect_to "/pictures"
    else
      # otherwise render new.html.erb
      render :new
    end

  end

  def edit
    @picture = Picture.find(params[:id])
  end

  def update
    @picture = Picture.find(params[:id])

    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]

    if @picture.save
    # if the picture gets saved, generate a get request to "/pictures" (the index)
      redirect_to "/pictures"
    else
    # otherwise render new.html.erb
      render :new
    end
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    redirect_to "/pictures"
  end


end
