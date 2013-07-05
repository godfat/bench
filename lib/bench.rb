
module Bench
  module_function
  def emit_json
    "#{Yajl::Encoder.encode(sample_hash)}\n"
  end

  def sample_hash
    h = Hash[(0...26).zip('a'..'z')]
    h.merge(h.invert).merge('caller' => caller_name)
  end

  def caller_name
    File.basename(caller_locations[2].absolute_path)
  end
end
