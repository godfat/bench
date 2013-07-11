
require 'bench'
require 'jellyfish'

class Bench::JellyfishCore
  include ::Jellyfish
  get do
    Bench.emit_json
  end
end

Bench::Jellyfish = Rack::Builder.app do
  use Rack::ContentLength
  use Rack::ContentType
  run Bench::JellyfishCore.new
end
