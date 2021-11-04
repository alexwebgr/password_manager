class HomeController < ApplicationController
  def index
  end

  def handle_upload
    render json: { message: 'required param filename is missing' }, status: 422 and return if params[:filename].blank?

    content_type = params[:filename].content_type
    render json: { message: 'only csv files are supported' }, status: 422 and return if content_type != 'text/csv'

    file = params[:filename].tempfile

    @results = UserService.create_users(file)
  rescue CSV::MalformedCSVError
    render json: { message: 'csv is malformed' }, status: 422
  end
end
