# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let!(:user) { FactoryBot.create(:user, email: email, password: password) }
  let(:email) { 'test@email.co' }
  let(:password) { 'password' }

  describe 'POST /login' do
    subject { post '/login', params: params }
    let(:params) do
      {
        user: {
          email: email,
          password: password
        }
      }
    end

    context 'when the request is valid' do
      it 'sets user_id into rails session' do
        subject
        expect(session[:user_id]).to eq(user.id)
      end
    end

    context 'when the request is invalid' do
      let(:params) do
        {
          user: {
            email: email,
            password: 'wrong_password'
          }
        }
      end

      it 'does not set user_id to rails session' do
        subject
        expect(session[:user_id]).to be_nil
      end

      it 'returns errors' do
        subject
        expect(response).to have_http_status(401)
        expect(JSON.parse(response.body)['errors']).to eq(['no such user, please try again'])
      end
    end
  end

  describe 'POST /logout' do
    subject { post '/logout' }

    let(:params) do
      {
        user: {
          email: email,
          password: password
        }
      }
    end

    before do
      post '/login', params: params
    end

    it 'removes user_id from rails session' do
      expect(session[:user_id]).to_not be_nil
      subject
      expect(session[:user_id]).to be_nil
    end
  end

  describe 'GET /logged_in' do
    subject { get '/logged_in' }

    context 'when user is logged in' do
      let(:params) do
        {
          user: {
            email: email,
            password: password
          }
        }
      end

      before do
        post '/login', params: params
      end

      it 'returns logged_in true' do
        subject
        expect(JSON.parse(response.body)['logged_in']).to be_truthy
      end

      it "returns user's attributes" do
        subject
        expect(JSON.parse(response.body)['user']['id']).to eq(user.id)
        expect(JSON.parse(response.body)['user']['email']).to eq(user.email)
        expect(JSON.parse(response.body)['user']['name']).to eq(user.name)
      end
    end
  end
end
