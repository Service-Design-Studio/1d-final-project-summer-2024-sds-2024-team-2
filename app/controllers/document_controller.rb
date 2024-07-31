class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  # GET /documents/new
  def new
    @document = Document.new
  end

  # POST /documents
  def create
    @document = Document.new(document_params)
    if @document.save
      redirect_to @document, notice: 'Document was successfully uploaded.'
    else
      render :new
    end
  end

  # GET /documents/:id
  def show
    # Display document details
  end

  # GET /documents/:id/edit
  def edit
    # Provide editing capabilities for a document
  end

  # PATCH/PUT /documents/:id
  def update
    if @document.update(document_params)
      redirect_to @document, notice: 'Document was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /documents/:id
  def destroy
    @document.destroy
    redirect_to documents_url, notice: 'Document was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_document
    @document = Document.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def document_params
    params.require(:document).permit(:title, :file, :description)
  end
end
