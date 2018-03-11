class FiguresController < ApplicationController
  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'/figures/new'
  end

  post '/figures/' do
    @figure = Figure.create(:name => params[:figure][:name])
    @figure.title_ids = params[:figure][:title_ids]
    @figure.titles << Title.find_or_create_by(name: params[:new_title]) if !params[:new_title].empty?
    @figure.landmark_ids = params[:figure][:landmark_ids]
    @figure.landmarks << Landmark.find_or_create_by(name: params[:new_landmark])  if !params[:new_landmark].empty?
  #  if !params[:figure][:title_ids].empty?
  #    @figure.titles << Title.find(params[:figure][:title_ids])
  #  elsif !params[:figure][:new_title].empty?
  #    new_title = Title.create(:name => params[:figure][:new_title].first)
  #    @figure.titles << new_title
  #  elsif !params[:figure][:landmark_ids].empty?
  #    binding.pry
  #    @figure.landmarks << Landmark.find(params[:figure][:landmark_ids])
  #  elsif !params[:figure][:new_landmark].empty?
  #    new_landmark = Landmark.create(:name => params[:figure][:new_landmark].first)
  #    @figure.landmarks << new_landmark
  #  end
    @figure.save
    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end

  post '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(:name => params[:figure][:name])
    @figure.title_ids = params[:figure][:title_ids]
    @figure.titles << Title.find_or_create_by(name: params[:new_title]) if !params[:new_title].empty?
    @figure.landmark_ids = params[:figure][:landmark_ids]
    @figure.landmarks << Landmark.find_or_create_by(name: params[:new_landmark])  if !params[:new_landmark].empty?
    @figure.save
    redirect "/figures/#{@figure.id}"
  end
end
