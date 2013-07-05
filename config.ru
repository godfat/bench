# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

require 'bench/jellyfish'
require 'bench/sinatra'

map '/jellyfish' do run Bench::Jellyfish  end
map '/sinatra'   do run Bench::Sinatra    end
map '/rails'     do run Rails.application end
