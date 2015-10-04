Write unit test in post_spec.rb

```ruby
RSpec.describe Post, type: :model do

  describe "attributes" do
    it "should respond to title" do
      expect(post).to respond_to(:title)
    end
  end

end
```

Run rspec post_spec.rb

```
$ rspec spec/models/post_spec.rb
F

Failures:

  1) Post attributes should respond to title
     Failure/Error: expect(post).to respond_to(:title)
     NameError:
       undefined local variable or method `post' for #<RSpec::ExampleGroups::Post::Attributes:0x44cac00>
     # ./spec/models/post_spec.rb:7:in `block (3 levels) in <top (required)>'

Finished in 0.003 seconds (files took 6.92 seconds to load)
1 example, 1 failure

Failed examples:

rspec ./spec/models/post_spec.rb:6 # Post attributes should respond to title
```

Added code below, to make failing test, pass, in post_spec.rb

```ruby
post = Post.create!(title: "Title")
```

Run rspec post_spec.rb

```
$ rspec spec/models/post_spec.rb
.

Finished in 0.022 seconds (files took 6.84 seconds to load)
1 example, 0 failures
```

Write unit test in post_spec.rb

```ruby
it "should respond to body" do
  expect(post).to respond_to(:body)
end
```

Run rspec post_spec.rb

```
$ rspec spec/models/post_spec.rb
.F

Failures:

  1) Post attributes should respond to body
     Failure/Error: expect(post).to respond_to(:body)
     NameError:
       undefined local variable or method `post' for #<RSpec::ExampleGroups::Post::Attributes:0x571e6f0>
     # ./spec/models/post_spec.rb:12:in `block (3 levels) in <top (required)>'

Finished in 0.018 seconds (files took 6.82 seconds to load)
2 examples, 1 failure

Failed examples:

rspec ./spec/models/post_spec.rb:11 # Post attributes should respond to body
```

Write code to make failing unit test, pass, in post_spec.rb

```ruby
post = Post.create!(body: "Body")
```

Run rspec post_spec.rb

```
$ rspec spec/models/post_spec.rb
..

Finished in 0.019 seconds (files took 6.8 seconds to load)
2 examples, 0 failures
```

Refactor in post_spec.rb

```ruby
RSpec.describe Post, type: :model do
  let(:post) { Post.create!(title: "Title", body: "Body") }

  describe "attributes" do
    it "should respond to title" do
      expect(post).to respond_to(:title)
    end

    it "should respond to body" do
      expect(post).to respond_to(:body)
    end
  end

end
```

Run rspec post_spec.rb

```
$ rspec spec/models/post_spec.rb
..

Finished in 0.019 seconds (files took 6.87 seconds to load)
2 examples, 0 failures
```

Write unit test for index in posts_controller_spec.rb

```ruby
it "assigns [my_post] to @posts" do
  get :index
  expect(assigns(:posts:)).to eq([my_post])
end
```

Run rspec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
.F

Failures:

  1) PostsController GET #index assigns [my_post] to @posts
     Failure/Error: expect(assigns(:posts)).to eq([my_post])
     NameError:
       undefined local variable or method `my_post' for #<RSpec::ExampleGroups::PostsController::GETIndex:0x57bc4d8>
     # ./spec/controllers/posts_controller_spec.rb:14:in `block (3 levels) in <top (required)>'

Finished in 0.026 seconds (files took 6.84 seconds to load)
2 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:11 # PostsController GET #index assigns [my_post] to @posts
```

Write code to pass index unit test in post_controller_spec.rb

```ruby
my_post = Post.create!(title: "Title", body: "Body")
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
.F

Failures:

  1) PostsController GET #index assigns [my_post] to @posts
     Failure/Error: expect(assigns(:posts)).to eq([my_post])

       expected: [#<Post id: 1, title: "Title", body: "Body", created_at: "2015-10-02 05:03:33", updated_at: "2015-10-02 05:03:33">]
            got: nil

       (compared using ==)
     # ./spec/controllers/posts_controller_spec.rb:14:in `block (3 levels) in <top (required)>'

Finished in 0.16001 seconds (files took 6.92 seconds to load)
2 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:11 # PostsController GET #index assigns [my_post] to @posts
```

Write code in app/controllers/posts_controller.rb

```ruby
def index
  @posts = Post.all
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
..

Finished in 0.044 seconds (files took 6.85 seconds to load)
2 examples, 0 failures
```

Write unit test for new in post_controller_spec.rb

```ruby
it "renders the #new view" do
  expect(response).to render_template :new
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
...F

Failures:

  1) PostsController GET #new renders the #new view
     Failure/Error: expect(response).to render_template :new
       expecting <"new"> but rendering with <[]>
     # ./spec/controllers/posts_controller_spec.rb:25:in `block (3 levels) in <top (required)>'

Finished in 0.086 seconds (files took 6.85 seconds to load)
4 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:24 # PostsController GET #new renders the #new view
```

Write code to pass unit test in post_controller_spec.rb

```ruby
get :new
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
....

Finished in 0.063 seconds (files took 6.81 seconds to load)
4 examples, 0 failures
```

Write unit test for new in post_controller_spec.rb

```ruby
it "instantiates @post" do
  expect(assigns(:post)).not_to be_nil
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
....F

Failures:

  1) PostsController GET #new instantiates @post
     Failure/Error: expect(assigns(:post)).not_to be_nil
       expected: not nil
            got: nil
     # ./spec/controllers/posts_controller_spec.rb:30:in `block (3 levels) in <top (required)>'

Finished in 0.09301 seconds (files took 6.99 seconds to load)
5 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:29 # PostsController GET #new instantiates @post
```

Write code to pass unit test in post_controller_spec.rb

```ruby
get :new
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
....F

Failures:

  1) PostsController GET #new instantiates @post
     Failure/Error: expect(assigns(:post)).not_to be_nil
       expected: not nil
            got: nil
     # ./spec/controllers/posts_controller_spec.rb:31:in `block (3 levels) in <top (required)>'

Finished in 0.09101 seconds (files took 7.04 seconds to load)
5 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:29 # PostsController GET #new instantiates @post
```

Write code to pass unit test in posts_controller.rb

```ruby
def new
  @post = Post.new
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
.....

Finished in 0.065 seconds (files took 6.82 seconds to load)
5 examples, 0 failures
```

Write unit test for create in post_controller_spec.rb

```ruby
it "increases the number of Post by 1" do
  expect{post :create, post: {title: "Title", body: "Body"}}.to change(Post,:count).by(1)
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
.....F

Failures:

  1) PostsController GET #create increases the number of Post by 1
     Failure/Error: expect{post :create, post: {title: "Title", body: "Body"}}.to change(Post,:count).by(1)
       expected #count to have changed by 1, but was changed by 0
     # ./spec/controllers/posts_controller_spec.rb:40:in `block (3 levels) in <top (required)>'

Finished in 0.27902 seconds (files took 7.17 seconds to load)
6 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:39 # PostsController GET #create increases the number of Post by 1
```

Write code to pass unit test in posts_controller.rb

```ruby
def create
  @post = Post.new
  @post.title = params[:post][:title]
  @post.body = params[:post][:body]

  if @post.save
    flash[:notice] = "Post was saved."
    redirect_to @post
  else
    flash[:error] = "There was an error saving the post. Please try again."
    render :new
  end
end
```

Write unit test in post_controller_spec.rb

```ruby
it "assigns the new post to @post" do
  post :create, post: {title: "Title", body: "Body"}
  expect(assigns(:post)).to eq Post.last
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
.......

Finished in 0.13001 seconds (files took 7.12 seconds to load)
7 examples, 0 failures
```

Write unit test in post_controller_spec.rb

```ruby
it "redirects to the new post" do
  post :create, post: {title: "Title", body: "Body"}
  expect(response).to redirect_to Post.last
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
........

Finished in 0.14301 seconds (files took 7.11 seconds to load)
8 examples, 0 failures
```

Write unit test for show in post_controller_spec.rb

```ruby
it "renders the show view" do
  expect(response).to render_template :show
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
......F

Failures:

  1) PostsController GET #show renders the show view
     Failure/Error: expect(response).to render_template :show
       expecting <"show"> but rendering with <[]>
     # ./spec/controllers/posts_controller_spec.rb:58:in `block (3 levels) in <top (required)>'

Finished in 0.10001 seconds (files took 7.28 seconds to load)
7 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:57 # PostsController GET #show renders the show view
```

Write code to make unit test pass in post_controller_spec.rb

```ruby
get :show
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
.......

Finished in 0.07601 seconds (files took 7.19 seconds to load)
7 examples, 0 failures
```

Write unit test in post_controller_spec.rb

```ruby
it "assigns my_post to @post" do
  expect(assigns(:post)).to eq(@post)
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
..........F

Failures:

  1) PostsController GET #show assigns my_post to @post
     Failure/Error: expect(assigns(:post)).to eq(@post)

       expected: #<Post id: 11, title: "title", body: "body", created_at: "2015-10-04 00:31:40", updated_at: "2015-10-04 00:31:40">
            got: nil

       (compared using ==)
     # ./spec/controllers/posts_controller_spec.rb:67:in `block (3 levels) in <top (required)>'

Finished in 0.21701 seconds (files took 7.16 seconds to load)
11 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:65 # PostsController GET #show assigns my_post to @post
```

Write code to pass unit test in posts_controller.rb

```ruby
def show
  @post = Post.find(params[:id])
end
```

```ruby
get :show, {id: @post.id}
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
...........

Finished in 0.19901 seconds (files took 7.2 seconds to load)
11 examples, 0 failures

```

Write unit test for edit in post_controller_spec.rb

```ruby
it "returns http success" do
  get :edit
  expect(response).to have_http_status(:success)
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
........F

Failures:

  1) PostsController GET #edit returns http success
     Failure/Error: get :edit
     ActionController::UrlGenerationError:
       No route matches {:action=>"edit", :controller=>"posts"}
     # ./spec/controllers/posts_controller_spec.rb:74:in `block (3 levels) in <top (required)>'

Finished in 0.16701 seconds (files took 7.22 seconds to load)
9 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:73 # PostsController GET #edit returns http success
```

Write code to pass unit test in posts_controller.rb

```ruby
def edit
  @post = Post.find(params[:id])
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
........F

Failures:

  1) PostsController GET #edit returns http success
     Failure/Error: get :edit
     ActiveRecord::RecordNotFound:
       Couldn't find Post with 'id'=
     # ./app/controllers/posts_controller.rb:29:in `edit'
     # ./spec/controllers/posts_controller_spec.rb:74:in `block (3 levels) in <top (required)>'

Finished in 0.16701 seconds (files took 7.33 seconds to load)
9 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:73 # PostsController GET #edit returns http success
```

Add id in post_controller_spec.rb

```ruby
get :edit, {id: @post.id}
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
.........

Finished in 0.17401 seconds (files took 7.18 seconds to load)
9 examples, 0 failures
```

Write unit test in post_controller_spec.rb

```ruby
it "renders the edit view" do
  expect(response).to render_template :edit
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
.........F

Failures:

  1) PostsController GET #edit renders the edit view
     Failure/Error: expect(response).to render_template :edit
       expecting <"edit"> but rendering with <[]>
     # ./spec/controllers/posts_controller_spec.rb:79:in `block (3 levels) in <top (required)>'

Finished in 0.20101 seconds (files took 7.15 seconds to load)
10 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:78 # PostsController GET #edit renders the edit view
```

Write code to pass unit test in post_controller_spec.rb

```ruby
get :edit, {id: @post.id}
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
..........

Finished in 0.19201 seconds (files took 7.19 seconds to load)
10 examples, 0 failures
```

Write unit test in post_controller_spec.rb

```ruby
it "assigns post to be updated to @post" do
  expect(post_instance.id).to eq @post.id
  expect(post_instance.title).to eq @post.title
  expect(post_instance.body).to eq @post.body
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
..........F

Failures:

  1) PostsController GET #edit assigns post to be updated to @post
     Failure/Error: expect(post_instance.id).to eq @post.id
     NameError:
       undefined local variable or method `post_instance' for #<RSpec::ExampleGroups::PostsController::GETEdit:0x5995c38>
     # ./spec/controllers/posts_controller_spec.rb:84:in `block (3 levels) in <top (required)>'

Finished in 0.18801 seconds (files took 7.44 seconds to load)
11 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:83 # PostsController GET #edit assigns post to be updated to @post
```

Define post_instance

```ruby
post_instance = assigns(:post)
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
..........F

Failures:

  1) PostsController GET #edit assigns post to be updated to @post
     Failure/Error: expect(post_instance.id).to eq @post.id
     NoMethodError:
       undefined method `id' for nil:NilClass
     # ./spec/controllers/posts_controller_spec.rb:86:in `block (3 levels) in <top (required)>'

Finished in 0.20401 seconds (files took 7.56 seconds to load)
11 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:83 # PostsController GET #edit assigns post to be updated to @post
```

Write code to pass unit test in post_controller_spec.rb

```ruby
get :edit, {id: @post.id}
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
...........

Finished in 0.18901 seconds (files took 7.2 seconds to load)
11 examples, 0 failures
```

Write unit test for update in post_controller_spec.rb

```ruby
it "updates post with expected attributes" do
  new_title = "New Title"
  new_body = "New Body"

  put :update, id: @post.id, post: {title: new_title, body: new_body}

  updated_post = assigns(:post)
  expect(updated_post.id).to eq @post.id
  expect(updated_post.title).to eq new_title
  expect(updated_post.body).to eq new_body
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
..............F

Failures:

  1) PostsController GET #update updates post with expected attributes
     Failure/Error: expect(updated_post.id).to eq @post.id
     NoMethodError:
       undefined method `id' for nil:NilClass
     # ./spec/controllers/posts_controller_spec.rb:100:in `block (3 levels) in <top (required)>'

Finished in 0.26301 seconds (files took 7.23 seconds to load)
15 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:93 # PostsController GET #update updates post with expected attributes
```

Write code for update

```ruby
def update
  @post = Post.find(params[:id])
  @post.title = params[:post][:title]
  @post.body = params[:post][:body]

  if @post.save
    flash[:notice] = "Post was updated."
    redirect_to @post
  else
    flash[:error] = "There was an error saving the post. Please try again."
    render :edit
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
...............

Finished in 0.24401 seconds (files took 7.12 seconds to load)
15 examples, 0 failures
```

Write unit test in post_controller_spec.rb

```ruby
it "redirects to the updated post" do
  new_title = "New Title"
  new_body = "New Body"

  put :update, id: @post.id, post: {title: new_title, body: new_body}
  expect(response).to redirect_to @post
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
................

Finished in 0.25301 seconds (files took 7.23 seconds to load)
16 examples, 0 failures
```

Write unit test for destroy in post_controller_spec.rb

```ruby
it "deletes the post" do
  delete :destroy, {id: @post.id}
  count = Post.where({id: @post.id}).size
  expect(count).to eq 0
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
................F

Failures:

  1) PostsController GET #destroy deletes the post
     Failure/Error: expect(count).to eq 0

       expected: 0
            got: 1

       (compared using ==)
     # ./spec/controllers/posts_controller_spec.rb:118:in `block (3 levels) in <top (required)>'

Finished in 0.30502 seconds (files took 7.14 seconds to load)
17 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:115 # PostsController GET #destroy deletes the post
```

Write code to pass unit test in posts_controller.rb

```ruby
def destroy
  @post = Post.find(params[:id])

  if @post.destroy
    flash[:notice] = "\"#{@post.title}\" was deleted successfully."
    redirect_to posts_path
  else
    flash[:error] = "There was an error deleting the post."
    render :show
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
.................

Finished in 0.26502 seconds (files took 7.12 seconds to load)
17 examples, 0 failures
```

Write unit test in post_controller_spec.rb

```ruby
it "redirects to posts index" do
  delete :destroy, {id: @post.id}
  expect(response).to redirect_to posts_path
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
..................

Finished in 0.27902 seconds (files took 7.2 seconds to load)
18 examples, 0 failures
```
