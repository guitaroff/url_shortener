require 'rails_helper'

RSpec.describe UrlsController, type: :request do
  describe 'POST #create' do
    let(:base_url) { '/urls' }
    let(:params) { { url: { original_url: url } } }
    subject { post base_url, params: params }

    context 'with valid format' do
      valid_urls = %w[https://example.com http://example.com https://example.co]

      valid_urls.each do |valid_url|
        let(:url) { valid_url }

        it 'return status code 201' do
          subject
          expect(response).to have_http_status(201)
        end
      end
    end

    context 'with invalid format' do
      invalid_urls = %w[htt://example.com example.com https://example.c example123]

      invalid_urls.each do |invalid_url|
        let(:url) { invalid_url }

        it 'return status code 422' do
          subject
          expect(response).to have_http_status(422)
        end
      end
    end
  end
end
