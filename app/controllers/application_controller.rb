require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  get '/' do
    erb :index
  end
  # Create the get '/posts' controller action. This action should use Active Record to grab all of the posts
  # and store them in an instance variable, @posts. Then, it should render the index.erb view.
  #  That view should use erb to iterate over @posts and render them on the page.

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  post '/posts' do
  @post = Post.create(name: params[:name],content: params[:content])
  erb :index
  end

  get '/posts/new' do
    erb :new
  end

  get '/posts/show' do
    @posts = Post.all
    # binding.pry
    erb :index
  end

  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    erb :edit
  end

  get '/posts/:id/delete' do
    @post = Post.find(params[:id])

    erb :delete
  end

  get '/posts/:id' do
    @post = Post.find(params[:id])
    # "#{@post}"
    erb :show
  end

  patch '/posts/:id' do
    post = Post.find(params[:id])
    post.name = params[:name]
    post.content = params[:content]
    post.save
    redirect to "/posts/#{post.id}"
  end
   # patch '/info/:isbn' do
   #     book = Book.find_by(isbn: params[:isbn])
   #     book.title = params[:title]
   #     book.page_count = params[:number_pages]
   #     book.category = params[:category]
   #     book.save
   #     redirect to "/info/#{ params[:isbn] }"
   #   end
   delete '/posts/:id' do
     @post = Post.find(params[:id])
     post_name=@post.name
     @post.delete
     "#{post_name} was deleted"
   end
end#ApplicationController
