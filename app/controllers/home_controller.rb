require 'csv'
class HomeController < ApplicationController
  def index
  end

  def handle_upload
    render json: { message: 'required param filename is missing' }, status: 422 and return if params[:filename].blank?

    content_type = params[:filename].content_type
    render json: { message: 'only csv files are supported' }, status: 422 and return if content_type != 'text/csv'

    file = params[:filename].tempfile
    users = CSV.parse(file, headers: true)

    @results = users.map do |user|
      next unless user['name'] && user['password']

      user = User.new({
                        name: user['name'],
                        password: user['password']
                      })

      if user.save
        {
          name: user['name'],
          message: 'Import was successful',
          success: true
        }
      else
        {
          name: user['name'],
          message: user.errors.full_messages.join("\n")
        }
      end
    end

  rescue CSV::MalformedCSVError
    render json: { message: 'csv is malformed' }, status: 422
  end
end
