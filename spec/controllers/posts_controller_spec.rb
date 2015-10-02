require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_post] to @posts" do
      my_post = Post.create!(title: "Title", body: "Body")
      get :index
      expect(assigns(:posts)).to eq([my_post])
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

    it "instantiates @post" do
      get :new
      expect(assigns(:post)).not_to be_nil
    end
  end

#  describe "GET #create" do
#    it "returns http success" do
#      get :create
#      expect(response).to have_http_status(:success)
#    end
#
#    it "increases the number of Post by 1" do
#      expect{post :create, post: {title: "Title", body: "Body"}}.to change(Post,:count).by(1)
#    end
#
#    it "assigns the new post to @post" do
#        post :create, post: {title: "Title", body: "Body"}
#        expect(assigns(:post)).to eq Post.last
#    end
#  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end

    it "renders the show view" do
      get :show
      expect(response).to render_template :show
    end

    it "assigns my_post to @post" do
      expect(assigns(:post)).to eq(my_post)
    end
  end

#  describe "GET #edit" do
#    it "returns http success" do
#      get :edit
#      expect(response).to have_http_status(:success)
#    end
#  end
#
#  describe "GET #update" do
#    it "returns http success" do
#      get :update
#      expect(response).to have_http_status(:success)
#    end
#  end
#
#  describe "GET #destroy" do
#    it "returns http success" do
#      get :destroy
#      expect(response).to have_http_status(:success)
#    end
#  end

end
