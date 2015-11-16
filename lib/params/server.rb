require 'json'
require 'pp'
require 'set'

module Params
  class Server < Sinatra::Base
    set :bind, '127.0.0.1'
    set :port, 8000
    disable :show_exceptions
    enable :logging, :dump_errors

    set :root, Params.root_folder

    not_found do
      # require 'pry'
      # binding.pry

      halt 200, {'Content-Type' => 'text/plain'}, erb(:show_params)
    end

    # # requires Sinatra::MultiRoute (sinatra/multi_route)
    # route :head, :delete, :get, :options, :patch, :post, :put, '/' do
    #   halt 200, {'Content-Type' => 'text/plain'}, erb(:show_params)
    # end

    get(/\A\/(test|form)(\.html)?\z/) do
      @action_target = './'

      if params[:port]
        port = Integer(params[:port])
        @action_target = "//#{request.host}:#{port}/"
      end

      erb(:form)
    end

    helpers do
      # A set of headers that rack does not prefix with `HTTP_`.
      # These headers are treated specially by the CGI RFC3875.
      UnprefixedHeaders = %w{CONTENT_TYPE CONTENT_LENGTH}.to_set

      # Get HTTP request headers.
      #
      # @return [Array<Array(String, String)>] Headers as [key, value]
      def get_request_headers
        request.env.find_all {|k, v|
          UnprefixedHeaders.include?(k) || k.start_with?('HTTP_')
        }.map {|k, v|
          range = UnprefixedHeaders.include?(k) ? 0..-1 : 1..-1
          [k.split('_')[range].map(&:downcase).map(&:capitalize).join('-'),
           v]
        }
      end
    end
  end
end
