# TDD Workflow [Red, Green, Refactor]



## Model Testing

# Test

Write unit test for title attribute for post_spec.rb model

```ruby
RSpec.describe Post, type: :model do
  describe "attributes" do
    it "should respond to title" do
      post = Post.create(title: "Title") # should fail due to no post class.
    end
  end
end
```

# Failure

Run rspec post_spec.rb
# Update error message (should be missing post class)
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

Write `let(:post) { Post.create!(title: "Title") }` inside title attribute unit test to make failing test for undefined local variable post, pass, in post_spec.rb model

# Implementation

```ruby
rails g model post title:string
```

# Pass

Run rspec post_spec.rb

```
$ rspec spec/models/post_spec.rb
.

Finished in 0.022 seconds (files took 6.84 seconds to load)
1 example, 0 failures
```

Write unit test for body attribute in post_spec.rb model

```ruby
RSpec.describe Post, type: :model do
  describe "attributes" do
    ...

    it "#title" do
      post = Post.create(title: "some title")
    
      expect(post.title).to respond_to("some title")
    end
  end
end
```

Run rspec post_spec.rb
# should pass due to implementation
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

Write `let(:post) { Post.create!(body: "Body") }` inside body attribute unit test to make failing test for undefined local variable post, pass, in post_spec.rb

```ruby
RSpec.describe Post, type: :model do
  describe "attributes" do
    ...

    it "should respond to body" do
      post = Post.create(body: "some body")

    end
  end
end

```

Run rspec post_spec.rb
# should fail due to no body attribute
```
$ rspec spec/models/post_spec.rb
..

Finished in 0.019 seconds (files took 6.8 seconds to load)
2 examples, 0 failures
```

# write a migration file for body

```ruby
rails g migration add_body_to_posts body:string
```

# run rspec

# should pass

---
## Controller Testing

Write unit test for `GET #index` in posts_controller_spec.rb

```ruby
require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
    end
  end
end
```

Run rspec posts_controller_spec.rb

```
$ rspec spec/controllers
F

Failures:

  1) PostsController GET #index returns http success
     Failure/Error: get :index
     ActionController::UrlGenerationError:
       No route matches {:action=>"index", :controller=>"posts"}
     # ./spec/controllers/posts_controller_spec.rb:11:in `block (3 levels) in <top (required)>'

Finished in 0.14701 seconds (files took 8.01 seconds to load)
1 example, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:10 # PostsController GET #index returns http success
```

Input `get "posts" => "posts#index"` route in routes.rb to make failing test for no route matches, pass

```ruby
Rails.application.routes.draw do
  get "posts" => "posts#index"
end

```

Run rspec posts_controller_spec.rb

```
$ rspec spec/controllers
.

Finished in 0.27102 seconds (files took 7.92 seconds to load)
1 example, 0 failures
```

Write test expecting response to have http status of success for GET #index in posts_controller_spec.rb

```ruby
require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
```
# should fail due to no controller index action

Run rspec posts_controller_spec.rb

```
$ rspec spec/controllers
.

Finished in 0.32702 seconds (files took 8.06 seconds to load)
1 example, 0 failures
```

Write unit test `assigns [post] to @posts` for GET #index in posts_controller_spec.rb

```ruby
RSpec.describe PostsController, type: :controller do
  describe "GET #index" do
    ...

    it "assigns [post] to @posts" do
      expect(assigns(:posts)).to eq([@post])
    end
  end
end
```

Run rspec posts_controller_spec.rb

```
$ rspec spec/controllers
.F

Failures:

  1) PostsController GET #index assigns [post] to @posts
     Failure/Error: expect(assigns(:posts)).to eq([@post])

       expected: [nil]
            got: nil

       (compared using ==)
     # ./spec/controllers/posts_controller_spec.rb:18:in `block (3 levels) in <top (required)>'

Finished in 0.59803 seconds (files took 8 seconds to load)
2 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:15 # PostsController GET #index assigns [post] to @posts
```

Write `get :index` "in assigns [post] to @posts" test for GET #index in posts_controller_spec.rb

```ruby
RSpec.describe PostsController, type: :controller do
  describe "GET #index" do
    ...

    it "assigns [post] to @posts" do
      get :index
      expect(assigns(:posts)).to eq([@post])
    end
  end
end
```

Run rspec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
.F

Failures:

  1) PostsController GET #index assigns [post] to @posts
     Failure/Error: expect(assigns(:posts)).to eq([post])
     NameError:
       undefined local variable or method `post' for #<RSpec::ExampleGroups::PostsController::GETIndex:0x57bc4d8>
     # ./spec/controllers/posts_controller_spec.rb:14:in `block (3 levels) in <top (required)>'

Finished in 0.026 seconds (files took 6.84 seconds to load)
2 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:11 # PostsController GET #index assigns [post] to @posts
```

Write code to pass index unit test in post_controller_spec.rb

```ruby
RSpec.describe PostsController, type: :controller do
  describe "GET #index" do
    ...

    it "assigns [post] to @posts" do
      get :index
      @post = Post.create!(title: "Title", body: "Body")
      expect(assigns(:posts)).to eq([@post])
    end
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
.F

Failures:

  1) PostsController GET #index assigns [post] to @posts
     Failure/Error: expect(assigns(:posts)).to eq([post])

       expected: [#<Post id: 1, title: "Title", body: "Body", created_at: "2015-10-02 05:03:33", updated_at: "2015-10-02 05:03:33">]
            got: nil

       (compared using ==)
     # ./spec/controllers/posts_controller_spec.rb:14:in `block (3 levels) in <top (required)>'

Finished in 0.16001 seconds (files took 6.92 seconds to load)
2 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:11 # PostsController GET #index assigns [my_post] to @posts
```

Define `index` method in app/controllers/posts_controller.rb

```ruby
class PostsController < ApplicationController
  def index
    @posts = Post.all
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
..

Finished in 0.044 seconds (files took 6.85 seconds to load)
2 examples, 0 failures
```

Write unit test for #new in post_controller_spec.rb

```ruby
RSpec.describe PostsController, type: :controller do
  ...

  describe "GET #new" do
    it "returns http success" do
      get :new
    end
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
..F

Failures:

  1) PostsController GET #new returns http success
     Failure/Error: get :new
     ActionController::UrlGenerationError:
       No route matches {:action=>"new", :controller=>"posts"}
     # ./spec/controllers/posts_controller_spec.rb:23:in `block (3 levels) in <top (required)>'

Finished in 0.44002 seconds (files took 7.99 seconds to load)
3 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:22 # PostsController GET #new returns http success
```

Input `get "posts/new" => "posts#new"` route in routes.rb to make failing test for no route matches, pass

```ruby
Rails.application.routes.draw do
  get "posts" => "posts#index"
  get "posts/new" => "posts#new"
end

```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
...

Finished in 0.43102 seconds (files took 7.98 seconds to load)
3 examples, 0 failures
```

Write test expecting response to have http status of success for GET #new in posts_controller_spec.rb

```ruby
describe "GET #new" do
  it "returns http success" do
    get :new
    expect(response).to have_http_status(:success)
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
...

Finished in 0.48903 seconds (files took 8.35 seconds to load)
3 examples, 0 failures
```

Write test expecting to render template for new in post_controller_spec.rb

```ruby
describe "GET #new" do
  ...

  it "renders the #new view" do
    expect(response).to render_template :new
  end
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

Write call for `get :new` in unit test for GET #new in post_controller_spec.rb

```ruby
describe "GET #new" do
  ...

  it "renders the #new view" do
    get :new
    expect(response).to render_template :new
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
....

Finished in 0.063 seconds (files took 6.81 seconds to load)
4 examples, 0 failures
```

Write test expecting assigning post to not be nil for new in post_controller_spec.rb

```ruby
describe "GET #new" do
  ...

  it "instantiates @post" do
    expect(assigns(:post)).not_to be_nil
  end
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

Write call for `get :new` in unit test for GET #new in post_controller_spec.rb

```ruby
describe "GET #new" do
  ...

  it "instantiates @post" do
    get :new
    expect(assigns(:post)).not_to be_nil
  end
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
     # ./spec/controllers/posts_controller_spec.rb:31:in `block (3 levels) in <top (required)>'

Finished in 0.09101 seconds (files took 7.04 seconds to load)
5 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:29 # PostsController GET #new instantiates @post
```

Define `new` method in posts_controller.rb

```ruby
class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
.....

Finished in 0.065 seconds (files took 6.82 seconds to load)
5 examples, 0 failures
```

Write unit test expecting post count to change by 1 when creating new post in post_controller_spec.rb

```ruby
RSpec.describe PostsController, type: :controller do
  ...

  describe "GET #create" do
    it "increases the number of Post by 1" do
      expect{post :create, post: {title: "Title", body: "Body"}}.to change(Post,:count).by(1)
    end
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
.....F

Failures:

  1) PostsController GET #create increases the number of Post by 1
     Failure/Error: expect{post :create, post: {title: "Title", body: "Body"}}.to change(Post,:count).by(1)
     ActionController::UrlGenerationError:
       No route matches {:action=>"create", :controller=>"posts", :post=>{:title=>"Title", :body=>"Body"}}
     # ./spec/controllers/posts_controller_spec.rb:40:in `block (4 levels) in <top (required)>'
     # ./spec/controllers/posts_controller_spec.rb:40:in `block (3 levels) in <top (required)>'

Finished in 0.73504 seconds (files took 8.16 seconds to load)
6 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:39 # PostsController GET #create increases the number of Post by 1
```

Input `post "posts" => "posts#create"` route in routes.rb to make failing test for no route matches, pass

```ruby
Rails.application.routes.draw do
  get  "posts" => "posts#index"
  get  "posts/new" => "posts#new"
  post "posts" => "posts#create"
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

Define create method in posts_controller.rb

```ruby
class PostsController < ApplicationController
  ...

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
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
.....F

Failures:

  1) PostsController GET #create increases the number of Post by 1
     Failure/Error: expect{post :create, post: {title: "Title", body: "Body"}}.to change(Post,:count).by(1)
     NoMethodError:
       undefined method `post_url' for #<PostsController:0x000000078bbad0>
     # ./app/controllers/posts_controller.rb:17:in `create'
     # ./spec/controllers/posts_controller_spec.rb:40:in `block (4 levels) in <top (required)>'
     # ./spec/controllers/posts_controller_spec.rb:40:in `block (3 levels) in <top (required)>'

Finished in 0.58703 seconds (files took 8.03 seconds to load)
6 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:39 # PostsController GET #create increases the number of Post by 1
```

Input `get  "posts/:id" => "posts#show", as: "post"` route in routes.rb to make failing test for no route matches, pass

```ruby
Rails.application.routes.draw do
  get  "posts" => "posts#index"
  get  "posts/new" => "posts#new"
  post "posts" => "posts#create"
  get  "posts/:id" => "posts#show", as: "post"
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
......

Finished in 0.50403 seconds (files took 8.1 seconds to load)
6 examples, 0 failures
```

Write test expecting assigning post to equal last post in post_controller_spec.rb

```ruby
describe "GET #create" do
  ...

  it "assigns the new post to @post" do
    post :create, post: {title: "Title", body: "Body"}
    expect(assigns(:post)).to eq Post.last
  end
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
describe "GET #create" do
  ...

  it "redirects to the new post" do
    post :create, post: {title: "Title", body: "Body"}
    expect(response).to redirect_to Post.last
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers/posts_controller_spec.rb
........

Finished in 0.14301 seconds (files took 7.11 seconds to load)
8 examples, 0 failures
```

Write unit test expecting response to have http status of success for show in post_controller_spec.rb

```ruby
RSpec.describe PostsController, type: :controller do
  ...

  describe "GET #show" do
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end
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

Write call to `get :show` to make unit test pass in post_controller_spec.rb

```ruby
describe "GET #show" do
  it "returns http success" do
    get :show
    expect(response).to have_http_status(:success)
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
........F

Failures:

  1) PostsController GET #show returns http success
     Failure/Error: get :show
     ActionController::UrlGenerationError:
       No route matches {:action=>"show", :controller=>"posts"}
     # ./spec/controllers/posts_controller_spec.rb:56:in `block (3 levels) in <top (required)>'

Finished in 0.81805 seconds (files took 7.96 seconds to load)
9 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:55 # PostsController GET #show returns http success
```

Input `get  "posts" => "posts#show"` route in routes.rb to make failing test for no route matches, pass

```ruby
Rails.application.routes.draw do
  get  "posts" => "posts#index"
  get  "posts/new" => "posts#new"
  post "posts" => "posts#create"
  get  "posts/:id" => "posts#show", as: "post"
  get  "posts" => "posts#show"
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
........F

Failures:

  1) PostsController GET #show returns http success
     Failure/Error: get :show
     ActiveRecord::RecordNotFound:
       Couldn't find Post with 'id'=
     # ./app/controllers/posts_controller.rb:25:in `show'
     # ./spec/controllers/posts_controller_spec.rb:56:in `block (3 levels) in <top (required)>'

Finished in 0.70204 seconds (files took 8.13 seconds to load)
9 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:55 # PostsController GET #show returns http success
```

Associate id with post.id in unit test in post_controller_spec.rb

```ruby
describe "GET #show" do
  it "returns http success" do
    get :show, {id: @post.id}
    expect(response).to have_http_status(:success)
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
.........

Finished in 0.65304 seconds (files took 8.15 seconds to load)
9 examples, 0 failures
```

Refactor routes.rb by removing `get  "posts" => "posts#show"`

```ruby
Rails.application.routes.draw do
#  resources :posts
  get  "posts" => "posts#index"
  get  "posts/new" => "posts#new"
  post "posts" => "posts#create"
  get  "posts/:id" => "posts#show", as: "post"
end
```

Run RSpec posts_controller_spec.rb to confirm test still passes

```
$ rspec spec/controllers
.........

Finished in 0.81805 seconds (files took 8.09 seconds to load)
9 examples, 0 failures
```

Write unit test in post_controller_spec.rb

```ruby
describe "GET #show" do
  ...

  it "renders the show view" do
    expect(response).to render_template :show
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
.........F

Failures:

  1) PostsController GET #show renders the show view
     Failure/Error: expect(response).to render_template :show
       expecting <"show"> but rendering with <[]>
     # ./spec/controllers/posts_controller_spec.rb:62:in `block (3 levels) in <top (required)>'

Finished in 0.85005 seconds (files took 8.04 seconds to load)
10 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:60 # PostsController GET #show renders the show view
```

Write call to `get :show` with association to id to make unit test pass in post_controller_spec.rb

```ruby
describe "GET #show" do
  ...

  it "renders the show view" do
    get :show, {id: @post.id}
    expect(response).to render_template :show
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
..........

Finished in 0.67104 seconds (files took 8.2 seconds to load)
10 examples, 0 failures
```

Write unit test expecting assigning post equals to @post for show in post_controller_spec.rb

```ruby
describe "GET #show" do
  ...

  it "assigns post to @post" do
    expect(assigns(:post)).to eq(@post)
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
..........F

Failures:

  1) PostsController GET #show assigns post to @post
     Failure/Error: expect(assigns(:post)).to eq(@post)

       expected: #<Post id: 11, title: "title", body: "body", created_at: "2015-10-23 06:37:42", updated_at: "2015-10-23 06:37:42">
            got: nil

       (compared using ==)
     # ./spec/controllers/posts_controller_spec.rb:67:in `block (3 levels) in <top (required)>'

Finished in 0.92405 seconds (files took 8.48 seconds to load)
11 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:65 # PostsController GET #show assigns post to @post
```

Define `show` method in posts_controller.rb

```ruby
class PostsController < ApplicationController
  ...

  def show
    @post = Post.find(params[:id])
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
..........F

Failures:

  1) PostsController GET #show assigns post to @post
     Failure/Error: expect(assigns(:post)).to eq(@post)

       expected: #<Post id: 11, title: "title", body: "body", created_at: "2015-10-23 06:41:33", updated_at: "2015-10-23 06:41:33">
            got: nil

       (compared using ==)
     # ./spec/controllers/posts_controller_spec.rb:67:in `block (3 levels) in <top (required)>'

Finished in 1.16 seconds (files took 8.16 seconds to load)
11 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:65 # PostsController GET #show assigns post to @post
```

Write call to `get :show` with association to id to make unit test pass in post_controller_spec.rb

```ruby
describe "GET #show" do
  ...

  it "assigns post to @post" do
    get :show, {id: @post.id}
    expect(assigns(:post)).to eq(@post)
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
...........

Finished in 1.39 seconds (files took 9.01 seconds to load)
11 examples, 0 failures
```

Write unit test expecting http success for edit in post_controller_spec.rb

```ruby
RSpec.describe PostsController, type: :controller do
  ...

  describe "GET #edit" do
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
............

Finished in 1.25 seconds (files took 8.25 seconds to load)
12 examples, 0 failures
```

Write unit test expecting to render the edit view for edit in post_controller_spec.rb

```ruby
describe "GET #edit" do
  ...

  it "renders the edit view" do
    expect(response).to render_template :edit
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
............F

Failures:

  1) PostsController GET #edit renders the edit view
     Failure/Error: expect(response).to render_template :edit
       expecting <"edit"> but rendering with <[]>
     # ./spec/controllers/posts_controller_spec.rb:79:in `block (3 levels) in <top (required)>'

Finished in 1.31 seconds (files took 8.27 seconds to load)
13 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:77 # PostsController GET #edit renders the edit view
```

Write call to `get :edit` with association to id to make unit test pass in post_controller_spec.rb

```ruby
describe "GET #edit" do
  ...

  it "renders the edit view" do
    get :edit
    expect(response).to render_template :edit
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
............F

Failures:

  1) PostsController GET #edit renders the edit view
     Failure/Error: get :edit
     ActionController::UrlGenerationError:
       No route matches {:action=>"edit", :controller=>"posts"}
     # ./spec/controllers/posts_controller_spec.rb:78:in `block (3 levels) in <top (required)>'

Finished in 1.37 seconds (files took 8.34 seconds to load)
13 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:77 # PostsController GET #edit renders the edit view
```

Input `get  "posts/:id/edit" => "posts#edit"` route in routes.rb to make failing test for no route matches, pass

```ruby
Rails.application.routes.draw do
  get  "posts" => "posts#index"
  get  "posts/new" => "posts#new"
  post "posts" => "posts#create"
  get  "posts/:id" => "posts#show", as: "post"
  get  "posts" => "posts#show"
  get  "posts/edit"
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
.............

Finished in 1.26 seconds (files took 9.13 seconds to load)
13 examples, 0 failures
```

Write unit test assigning post to be updated to @post for GET #edit in post_controller_spec.rb

```ruby
describe "GET #edit" do
  ...

  it "assigns post to be updated to @post" do
    expect(post_instance.id).to eq @post.id
    expect(post_instance.title).to eq @post.title
    expect(post_instance.body).to eq @post.body
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
.............F

Failures:

  1) PostsController GET #edit assigns post to be updated to @post
     Failure/Error: expect(post_instance.id).to eq @post.id
     NameError:
       undefined local variable or method `post_instance' for #<RSpec::ExampleGroups::PostsController::GETEdit:0x00000006bdaff0>
     # ./spec/controllers/posts_controller_spec.rb:86:in `block (3 levels) in <top (required)>'

Finished in 1.69 seconds (files took 9 seconds to load)
14 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:82 # PostsController GET #edit assigns post to be updated to @post
```

Define post_instance in unit test for GET #edit in post_controller_spec.rb

```ruby
describe "GET #edit" do
  ...

  it "assigns post to be updated to @post" do
    post_instance = assigns(:post)

    expect(post_instance.id).to eq @post.id
    expect(post_instance.title).to eq @post.title
    expect(post_instance.body).to eq @post.body
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
.............F

Failures:

  1) PostsController GET #edit assigns post to be updated to @post
     Failure/Error: expect(post_instance.id).to eq @post.id
     NoMethodError:
       undefined method `id' for nil:NilClass
     # ./spec/controllers/posts_controller_spec.rb:86:in `block (3 levels) in <top (required)>'

Finished in 2.43 seconds (files took 8.26 seconds to load)
14 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:82 # PostsController GET #edit assigns post to be updated to @post
```

Define `edit` method in posts_controller.rb

```ruby
class PostsController < ApplicationController
  ...

  def edit
    @post = Post.find(params[:id])
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
............FF

Failures:

  1) PostsController GET #edit renders the edit view
     Failure/Error: get :edit
     ActiveRecord::RecordNotFound:
       Couldn't find Post with 'id'=
     # ./app/controllers/posts_controller.rb:29:in `edit'
     # ./spec/controllers/posts_controller_spec.rb:78:in `block (3 levels) in <top (required)>'

  2) PostsController GET #edit assigns post to be updated to @post
     Failure/Error: expect(post_instance.id).to eq @post.id
     NoMethodError:
       undefined method `id' for nil:NilClass
     # ./spec/controllers/posts_controller_spec.rb:86:in `block (3 levels) in <top (required)>'

Finished in 1.37 seconds (files took 8.07 seconds to load)
14 examples, 2 failures

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:77 # PostsController GET #edit renders the edit view
rspec ./spec/controllers/posts_controller_spec.rb:82 # PostsController GET #edit assigns post to be updated to @post
```

Write call to `get :show` with association to id to make unit test pass in post_controller_spec.rb

```ruby
describe "GET #edit" do
  ...

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
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
..............

Finished in 1.39 seconds (files took 8.55 seconds to load)
14 examples, 0 failures
```

Write unit test expecting updating a post with expected attributes for GET #update in post_controller_spec.rb

```ruby
RSpec.describe PostsController, type: :controller do
  ...

  describe "GET #update" do
    it "updates post with expected attributes" do
      updated_post = assigns(:post)
      expect(updated_post.id).to eq @post.id
      expect(updated_post.title).to eq new_title
      expect(updated_post.body).to eq new_body
    end
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
..............F

Failures:

  1) PostsController GET #update updates post with expected attributes
     Failure/Error: expect(updated_post.id).to eq @post.id
     NoMethodError:
       undefined method `id' for nil:NilClass
     # ./spec/controllers/posts_controller_spec.rb:100:in `block (3 levels) in <top (required)>'

Finished in 1.51 seconds (files took 8.23 seconds to load)
15 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:93 # PostsController GET #update updates post with expected attributes
```

Write call to `put :update` to make unit test pass for GET #update in post_controller_spec.rb

```ruby
describe "GET #update" do
  it "updates post with expected attributes" do
    put :update

    updated_post = assigns(:post)
    expect(updated_post.id).to eq @post.id
    expect(updated_post.title).to eq new_title
    expect(updated_post.body).to eq new_body
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
..............F

Failures:

  1) PostsController GET #update updates post with expected attributes
     Failure/Error: put :update
     ActionController::UrlGenerationError:
       No route matches {:action=>"update", :controller=>"posts"}
     # ./spec/controllers/posts_controller_spec.rb:97:in `block (3 levels) in <top (required)>'

Finished in 1.39 seconds (files took 8.26 seconds to load)
15 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:93 # PostsController GET #update updates post with expected attributes
```

Input `get  "posts" => "posts#update"` route in routes.rb to make failing test for no route matches, pass

```ruby
Rails.application.routes.draw do
  get  "posts" => "posts#index"
  get  "posts/new" => "posts#new"
  post "posts" => "posts#create"
  get  "posts/:id" => "posts#show", as: "post"
  get  "posts" => "posts#show"
  get  "posts/edit"
  get  "posts" => "posts#update"
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
..............F

Failures:

  1) PostsController GET #update updates post with expected attributes
     Failure/Error: expect(updated_post.id).to eq @post.id
     NoMethodError:
       undefined method `id' for nil:NilClass
     # ./spec/controllers/posts_controller_spec.rb:100:in `block (3 levels) in <top (required)>'

Finished in 1.47 seconds (files took 8.15 seconds to load)
15 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:93 # PostsController GET #update updates post with expected attributes
```

Associate id with post.id in unit test for GET #update in post_controller_spec.rb

```ruby
describe "GET #update" do
  it "updates post with expected attributes" do
    put :update, id: @post.id

    updated_post = assigns(:post)
    expect(updated_post.id).to eq @post.id
    expect(updated_post.title).to eq new_title
    expect(updated_post.body).to eq new_body
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
..............F

Failures:

  1) PostsController GET #update updates post with expected attributes
     Failure/Error: expect(updated_post.id).to eq @post.id
     NoMethodError:
       undefined method `id' for nil:NilClass
     # ./spec/controllers/posts_controller_spec.rb:100:in `block (3 levels) in <top (required)>'

Finished in 1.51 seconds (files took 8.32 seconds to load)
15 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:93 # PostsController GET #update updates post with expected attributes
```

Define `update` method in posts_controller.rb

```ruby
class PostsController < ApplicationController
  ...

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
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
..............F

Failures:

  1) PostsController GET #update updates post with expected attributes
     Failure/Error: put :update, id: @post.id
     NoMethodError:
       undefined method `[]' for nil:NilClass
     # ./app/controllers/posts_controller.rb:34:in `update'
     # ./spec/controllers/posts_controller_spec.rb:97:in `block (3 levels) in <top (required)>'

Finished in 1.72 seconds (files took 8.61 seconds to load)
15 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:93 # PostsController GET #update updates post with expected attributes
```

Set post in unit test in post_controller_spec.rb

```ruby
describe "GET #update" do
  it "updates post with expected attributes" do
    put :update, id: @post.id, post: {title: new_title, body: new_body}

    updated_post = assigns(:post)
    expect(updated_post.id).to eq @post.id
    expect(updated_post.title).to eq new_title
    expect(updated_post.body).to eq new_body
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
..............F

Failures:

  1) PostsController GET #update updates post with expected attributes
     Failure/Error: put :update, id: @post.id, post: {title: new_title, body: new_body}
     NameError:
       undefined local variable or method `new_title' for #<RSpec::ExampleGroups::PostsController::GETUpdate:0x000000054df0f8>
     # ./spec/controllers/posts_controller_spec.rb:97:in `block (3 levels) in <top (required)>'

Finished in 1.22 seconds (files took 8.32 seconds to load)
15 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:93 # PostsController GET #update updates post with expected attributes
```

Define new_title and new_body variables in unit test for GET #update in post_controller_spec.rb

```ruby
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
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
...............

Finished in 1.87 seconds (files took 8.45 seconds to load)
15 examples, 0 failures
```

Write unit test expecting a redirect to the updated post for GET #update in post_controller_spec.rb

```ruby
describe "GET #update" do
  ...

  it "redirects to the updated post" do
    new_title = "New Title"
    new_body = "New Body"

    put :update, id: @post.id, post: {title: new_title, body: new_body}
    expect(response).to redirect_to @post
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
................

Finished in 3.89 seconds (files took 8.6 seconds to load)
16 examples, 0 failures
```

Write unit test expecting a post to be deleted for GET #destroy in post_controller_spec.rb

```ruby
RSpec.describe PostsController, type: :controller do
  ...

  describe "GET #destroy" do
    it "deletes the post" do
      count = Post.where({id: @post.id}).size
      expect(count).to eq 0
    end
  end
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

```ruby
describe "GET #destroy" do
  it "deletes the post" do
    delete :destroy
    count = Post.where({id: @post.id}).size
    expect(count).to eq 0
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
................F

Failures:

  1) PostsController GET #destroy deletes the post
     Failure/Error: delete :destroy, {id: @post.id}
     ActionController::UrlGenerationError:
       No route matches {:action=>"destroy", :controller=>"posts", :id=>"11"}
     # ./spec/controllers/posts_controller_spec.rb:116:in `block (3 levels) in <top (required)>'

Finished in 1.47 seconds (files took 8.18 seconds to load)
17 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:115 # PostsController GET #destroy deletes the post
```

Input `delete  "posts/:id" => "posts#destroy"` route in routes.rb to make failing test for no route matches, pass

```ruby
Rails.application.routes.draw do
  get     "posts" => "posts#index"
  get     "posts/new" => "posts#new"
  post    "posts" => "posts#create"
  get     "posts/:id" => "posts#show", as: "post"
  get     "posts" => "posts#show"
  get     "posts/edit"
  get     "posts" => "posts#update"
  delete  "posts/:id" => "posts#destroy"
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
................F

Failures:

  1) PostsController GET #destroy deletes the post
     Failure/Error: expect(count).to eq 0

       expected: 0
            got: 1

       (compared using ==)
     # ./spec/controllers/posts_controller_spec.rb:118:in `block (3 levels) in <top (required)>'

Finished in 1.76 seconds (files took 8.39 seconds to load)
17 examples, 1 failure

Failed examples:

rspec ./spec/controllers/posts_controller_spec.rb:115 # PostsController GET #destroy deletes the post
```

Define `destroy` method in posts_controller.rb

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
$ rspec spec/controllers
.................

Finished in 1.61 seconds (files took 8.57 seconds to load)
17 examples, 0 failures
```

Write unit test expecting a redirect to posts index after a successful deletion for GET #destroy in post_controller_spec.rb

```ruby
describe "GET #destroy" do
  ...

  it "redirects to posts index" do
    delete :destroy, {id: @post.id}
    expect(response).to redirect_to posts_path
  end
end
```

Run RSpec posts_controller_spec.rb

```
$ rspec spec/controllers
..................

Finished in 1.86 seconds (files took 9.31 seconds to load)
18 examples, 0 failures
```

Refactor routes.rb

```ruby
Rails.application.routes.draw do
  resources :posts
end
```

Run RSpec posts_controller_spec.rb to confirm tests still pass

```
$ rspec spec/controllers
..................

Finished in 5.13 seconds (files took 9.42 seconds to load)
18 examples, 0 failures
```
