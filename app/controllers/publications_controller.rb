class PublicationsController < ApplicationController
  before_action :set_publication, only: %i[show edit update destroy]
  def index
    # @publications = Publication.latest
    # @publications = @publications.ai_generated if params[:ai_generated]
    #
    # respond_to do |format|
    #   format.html
    #   format.json { render json: @publications.as_json(include: [:author, :sources]) }
    # end

    @publications = Publication.includes(:author).order(created_at: :desc)
  end

  def show
  end

  def new
    @publication = Publication.new
  end

  def create
    @publication = Publication.new(publication_params)
    if @publication.save
      redirect_to @publication, notice: 'Publication was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @publication.update(publication_params)
      redirect_to @publication, notice: 'Publication was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @publication.destroy
    redirect_to publications_url, notice: 'Publication was successfully destroyed.'
  end

  private

  def set_publication
    @publication = Publication.find(params[:id])
  end

  def publication_params
    params.require(:publication).permit(:title, :description, :file)
  end
end
