class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json

'
  get '/games' do
    #get data from database
    games = Game.all.order(:title).limit(10)
    #return JSON response with array of game data
    games.to_json
  end

  get '/games/:id' do
    #look up game in db using id
    game = Game.find(params[:id])
    # send JSON response of game data
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
  end

end
