require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do 
    redirect '/posts'
  end

  get '/posts' do

  	@posts = Post.all
  	erb :index
  end


  get '/posts/new' do
  	erb :new
  end

  

  get '/posts/:id' do
  	@post = Post.find(params[:id])

  	erb :show
  end

  get '/posts/:id/edit' do
  	@post = Post.find(params[:id])

  	erb :edit
  end

  patch '/posts/:id' do
  	@post = Post.find(params[:id])
  	@post.name = params[:name]
  	@post.content = params[:content]
  	@post.save
  	erb :show
  end

  delete '/posts/:id/delete' do 
  	@name = Post.find(params[:id]).name
  	Post.delete(params[:id])

  	erb :delete
  end


  post '/posts' do
  	Post.create(params)
  	@posts = Post.all
  	redirect to '/posts'
  end
end