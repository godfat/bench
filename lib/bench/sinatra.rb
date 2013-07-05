
require 'bench'
require 'sinatra/base'

class Bench::Sinatra < ::Sinatra::Base
  get '/' do
    Bench.emit_json
  end
end
