class ApplicationController < Sinatra::Base
  set :default_content_type , "application/json"

  get '/games' do 
    games = Game.all.order(:id)
    games.to_json
  end

  # getting one game using params 
  # get '/games/:id' do #create a dynamic route using the :id
  #   game = Game.find(params[:id]) #yuse find or find_by method
  #   game.to_json(include: {reviews: {include: :user} }) #to include the users associated with each review
  # end

  #  be more selective about which attributes are returned from each model with the only option:
  get '/games/:id' do
    game = Game.find(params[:id])
    game.to_json(only: [:id, :title, :genre, :price], 
      include: { reviews: {only: [:comment, :score], 
      include: { user: { only: [:name] }
      } 
     }
    })
  end

end
