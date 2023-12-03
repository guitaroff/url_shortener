require 'rails_helper'

RSpec.describe UrlsController, type: :request do
  let(:base_url) { '/urls' }

  describe 'POST #create' do
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

  describe 'GET #shortened' do
    subject { get "#{base_url}/#{short_url}" }

    context 'status 200' do
      let!(:shortened_url) { create(:shortened_url) }
      let!(:short_url) { shortened_url.short_url }

      it 'return status code 200' do
        subject
        expect(response).to have_http_status(200)
      end

      it 'increases the counter by 1' do
        expect { subject; shortened_url.reload }.to change { shortened_url.view_count }.to 1
      end
    end

    context 'record not found' do
      let!(:short_url) { "ny17j2zz" }

      it 'return status code 404' do
        subject
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'GET #stats' do
    subject { get "#{base_url}/#{short_url}/stats" }

    context 'status 200' do
      let!(:shortened_url) { create(:shortened_url) }
      let!(:short_url) { shortened_url.short_url }

      before { shortened_url.update(view_count: 1) }

      it 'return status code 200' do
        subject
        expect(response).to have_http_status(200)
      end

      it 'return a counter' do
        subject
        expect(json['view_count']).to eq 1
      end
    end

    context 'record not found' do
      let!(:short_url) { "ny17j2zz" }

      it 'return status code 404' do
        subject
        expect(response).to have_http_status(404)
      end
    end
  end
end
