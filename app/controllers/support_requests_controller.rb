class SupportRequestsController < ApplicationController

  before_action :find_support_request, only: [:edit, :update, :destroy]



  def index
    @support_requests = SupportRequest.order("done DESC").
                        paginate({per_page: 5, page: params[:page]})
    session[:current_page] = params[:page]
    if params[:search]
      @search_term = params[:search]
      @support_requests = @support_requests.search_by(@search_term)
    end
  end

  def new
    @support_request = SupportRequest.new
  end

  def create
    @support_request = SupportRequest.
                        new(support_request_params)
    if @support_request.save
      redirect_to support_requests_path, notice: "Support Request Created Successfully!!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @support_request.update_attributes(support_request_params)
      redirect_to support_requests_path(page: session[:current_page]), notice: "Request updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    if @support_request.destroy
      redirect_to support_requests_path, notice: "Request deleted successfully!"
    else
      redirect_to support_requests_path, error: "Request wasn't deleted!"
    end
  end

  private

  def support_request_params
    params.require(:support_request).
            permit([:name, :email, :message, :department, :done])
  end

  def find_support_request
    @support_request = SupportRequest.find(params[:id])
  end
end
