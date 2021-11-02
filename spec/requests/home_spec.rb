require 'rails_helper'

RSpec.describe HomeController, type: :request do
  describe "GET /index" do
    it "returns http success" do
      get home_index_url
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /handle_upload" do
    describe 'when a valid file is uploaded' do
      let(:file) { fixture_file_upload('users.csv', 'text/csv') }

      it "returns http success" do
        post home_handle_upload_url, params: { filename: file }

        expect(response).to have_http_status(200)
      end
    end

    describe 'when filename param is missing' do
      let(:file) { nil }

      it "returns an error message" do
        post home_handle_upload_url, params: { filename: file }

        expect(response).to have_http_status(422)
        expect(response.parsed_body).to eq({ 'message' => 'required param filename is missing' })
      end
    end

    describe 'when a file with unsupported content type is uploaded' do
      let(:file) { fixture_file_upload('ruby_logo.jpg', 'image/jpeg') }

      it "returns an error message" do
        post home_handle_upload_url, params: { filename: file }

        expect(response).to have_http_status(422)
        expect(response.parsed_body).to eq({ 'message' => 'only csv files are supported' })
      end
    end

    describe 'when a malformed csv file is uploaded' do
      let(:file) { fixture_file_upload('malformed.csv', 'text/csv') }

      it "returns an error message" do
        post home_handle_upload_url, params: { filename: file }

        expect(response).to have_http_status(422)
        expect(response.parsed_body).to eq({ 'message' => 'csv is malformed' })
      end
    end

    describe 'when a file is uploaded with 3 valid users' do
      let(:file) { fixture_file_upload('users.csv', 'text/csv') }

      it "creates 3 new users" do
        expect {
          post home_handle_upload_url, params: { filename: file }
        }.to change(User, :count).by(3)
      end
    end
  end
end
