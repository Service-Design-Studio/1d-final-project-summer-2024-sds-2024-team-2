class DocumentsController < ApplicationController
  before_action :set_attachable
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  # GET /user_particulars/:user_particular_id/documents/new
  def new
    @document = @attachable.documents.build
  end

  # POST /user_particulars/:user_particular_id/documents
  def create
    @document = @attachable.documents.build(document_params)
    if @document.save
      redirect_to [@attachable, @document], notice: 'Document was successfully uploaded.'
    else
      render :new
    end
  end

  # GET /user_particulars/:user_particular_id/documents/:id
  def show
    # Display document details
  end

  # GET /user_particulars/:user_particular_id/documents/:id/edit
  def edit
    # Provide editing capabilities for a document
  end

  # PATCH/PUT /user_particulars/:user_particular_id/documents/:id
  def update
    if @document.update(document_params)
      redirect_to [@attachable, @document], notice: 'Document was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /user_particulars/:user_particular_id/documents/:id
  def destroy
    @document.destroy
    redirect_to user_particular_path(@attachable), notice: 'Document was successfully destroyed.'
  end

  private

  def set_attachable
    @attachable = UserParticular.find(params[:user_particular_id]) # Adjust as necessary for other attachable types
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_document
    @document = @attachable.documents.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def document_params
    params.require(:document).permit(:title, :file, :description)
  end
end
