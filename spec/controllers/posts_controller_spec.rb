require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  before do
    Post.destroy_all
    @post = Post.create!( title: "title", body: "body" )
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [post] to @posts" do
      get :index
      expect(assigns(:posts)).to eq([@post])
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

  describe "GET #create" do
    it "increases the number of Post by 1" do
      expect{post :create, post: {title: "Title", body: "Body"}}.to change(Post,:count).by(1)
    end

    it "assigns the new post to @post" do
      post :create, post: {title: "Title", body: "Body"}
      expect(assigns(:post)).to eq Post.last
    end

    it "redirects to the new post" do
      post :create, post: {title: "Title", body: "Body"}
      expect(response).to redirect_to Post.last
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: @post.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the show view" do
      get :show, {id: @post.id}
      expect(response).to render_template :show
    end

    it "assigns post to @post" do
      get :show, {id: @post.id}
      expect(assigns(:post)).to eq(@post)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
#      get :edit, {id: @post.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the edit view" do
      get :edit, {id: @post.id}
      expect(response).to render_template :edit
    end

    it "assigns post to be updated to @post" do
      get :edit, {id: @post.id}
      post_instance = assigns(:post)

      expect(post_instance.id).to eq @post.id
      expect(post_instance.title).to eq @post.title
      expect(post_instance.body).to eq @post.body
    end
  end

  describe "GET #update" do
    it "updates post with expected attributes" do
      new_title = "New Title"
      new_body = "New Body"

      put :update, id: @post.id, post: {title: new_title, body: new_body}

      updated_post = assigns(:post)
      expect(updated_post.id).to eq @post.id
      expect(updated_post.title).to eq new_title
      expect(updated_post.body).to eq new_body
    end

    it "redirects to the updated post" do
      new_title = "New Title"
      new_body = "New Body"

      put :update, id: @post.id, post: {title: new_title, body: new_body}
      expect(response).to redirect_to @post
    end
  end

  describe "GET #destroy" do
    it "deletes the post" do
      delete :destroy, {id: @post.id}
      count = Post.where({id: @post.id}).size
      expect(count).to eq 0
    end

    it "redirects to posts index" do
      delete :destroy, {id: @post.id}
      expect(response).to redirect_to posts_path
    end
  end
end
