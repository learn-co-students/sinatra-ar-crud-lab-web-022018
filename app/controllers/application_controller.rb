require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect "/posts"
  end

  get '/posts' do
    @posts = Post.all
    # binding.pry
    erb :index
  end

  get '/posts/new' do
    erb :new
  end

  post '/posts' do
    post = Post.create(params)
    redirect "/posts"
  end

  get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :show
  end


  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    # binding.pry
    erb :edit
  end

  patch '/posts/:id' do
    post = Post.find(params[:id])
    post.update(name: params[:name], content: params[:content])
    # binding.pry
    redirect "/posts/#{post.id}"
  end

  get "/posts/:id/delete" do
    # binding.pry
    @post = Post.find(params[:id])
    erb :delete
  end


  delete '/posts/:id' do
    @post = Post.find(params[:id])
    @post.destroy
    erb :delete
  end

end
