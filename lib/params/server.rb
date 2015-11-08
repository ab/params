require 'sinatra/multi_route'
require 'json'
require 'pp'

module Params
  class Server < Sinatra::Base
    register Sinatra::MultiRoute

    set :bind, '127.0.0.1'
    set :port, 6000
    disable :show_exceptions
    enable :logging, :dump_errors

    set :root, Params.root_folder

    not_found do
      # require 'pry'
      # binding.pry
      halt 200, {'Content-Type' => 'text/plain'}, erb(:show_params)
    end



    # route :head, :delete, :get, :options, :patch, :post, :put, '/' do
    #   halt 200, {'Content-Type' => 'text/plain'}, erb(:show_params)
    # end
  end
end
