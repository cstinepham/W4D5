require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  # new
  # create
  # index
  # show

  describe "GET #new" do
    it 'renders the new user template' do
      get :new
      expect(response).to render_template(:new)
    end
  end


  describe "POST #create" do
    context 'with valid params' do
      it 'logs in the user' do
        post :create, params: { user: { username: "Whatever", password: "password" }}
        user = User.find_by(username: "Whatever")
        expect(session[:session_token]).to eq(user.session_token)
      end

      it 'redirects the user to the show page' do
        post :create, params: { user: { username: "Whatever", password: "password" }}
        user = User.find_by(username: "Whatever")
        expect(response).to redirect_to(user_url(user))
      end
    end

    context 'with invalid paramas' do
      it 'should throw an error' do
        post :create, params: { user: { username: "", password: "password" }}
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end

    end
  end

  describe "GET #index" do
    it 'renders index page' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    context 'with an existing user' do
      it 'renders user\'s show page' do
        get :show
        expect(response).to render_template(:show)
      end
    end

    context 'with a non-existing user' do
      it 'redirect to users index page' do
        get :show
        expect(response).to redirect_to(users_url)
      end
    end
  end


end
