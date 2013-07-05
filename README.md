
# A Simple and Stupid Benchmark For Serving API For:

* Rails 4
* Sinatra 1.4
* Jellyfish 0.8

## Quick and Dirty Conclusion:

| Framework     | req/s | ratio | failing rate |
| -------------:|:-----:|:-----:|:------------:|
|       Rails 4 | 301.3 |  1.0  |      7%      |
|   Sinatra 1.4 | 589.2 |  2.0  |      0%      |
| Jellyfish 0.8 | 856.2 |  2.8  |      0%      |

## Application code:

    Bench.emit_json

## What it does:

``` ruby
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
```

## Run the server:

We run Rainbows! with ThreadPool concurrency model.

    ./bin/server

Which is simply:

    rainbows -E production -c config/rainbows.rb



# An Example Detailed Result:

## Rails 4

Command:

    ./bin/siege-rails

Result:

    Hitting /rails

    httperf --hog --timeout=60 --client=0/1 --server=localhost --port=8080 --uri=/rails --rate=100 --send-buffer=4096 --recv-buffer=16384 --num-conns=1000 --num-calls=10 --burst-length=2
    Maximum connect burst length: 2

    Total: connections 1000 requests 9310 replies 9310 test-duration 30.897 s

    Connection rate: 32.4 conn/s (30.9 ms/conn, <=608 concurrent connections)
    Connection time [ms]: min 16.1 avg 6695.5 max 18684.5 median 4404.5 stddev 4419.0
    Connection time [ms]: connect 4340.4
    Connection length [replies/conn]: 10.000

    Request rate: 301.3 req/s (3.3 ms/req)
    Request size [B]: 67.0

    Reply rate [replies/s]: min 0.0 avg 310.4 max 414.2 stddev 169.4 (6 samples)
    Reply time [ms]: response 713.3 transfer 0.0
    Reply size [B]: header 446.0 content 435.0 footer 0.0 (total 881.0)
    Reply status: 1xx=0 2xx=9310 3xx=0 4xx=0 5xx=0

    CPU time [s]: user 2.02 system 26.43 (user 6.5% system 85.5% total 92.1%)
    Net I/O: 279.0 KB/s (2.3*10^6 bps)

    Errors: total 69 client-timo 0 socket-timo 69 connrefused 0 connreset 0
    Errors: fd-unavail 0 addrunavail 0 ftab-full 0 other 0

## Sinatra 1.4

Command:

    ./bin/siege-sinatra

Result:

    Hitting /sinatra

    httperf --hog --timeout=60 --client=0/1 --server=localhost --port=8080 --uri=/sinatra --rate=100 --send-buffer=4096 --recv-buffer=16384 --num-conns=1000 --num-calls=10 --burst-length=2
    Maximum connect burst length: 2

    Total: connections 1000 requests 10000 replies 10000 test-duration 16.973 s

    Connection rate: 58.9 conn/s (17.0 ms/conn, <=430 concurrent connections)
    Connection time [ms]: min 6.7 avg 3764.2 max 11882.8 median 2786.5 stddev 2794.6
    Connection time [ms]: connect 1525.9
    Connection length [replies/conn]: 10.000

    Request rate: 589.2 req/s (1.7 ms/req)
    Request size [B]: 69.0

    Reply rate [replies/s]: min 587.4 avg 589.6 max 591.0 stddev 1.9 (3 samples)
    Reply time [ms]: response 443.4 transfer 0.0
    Reply size [B]: header 251.0 content 420.0 footer 0.0 (total 671.0)
    Reply status: 1xx=0 2xx=10000 3xx=0 4xx=0 5xx=0

    CPU time [s]: user 0.83 system 14.56 (user 4.9% system 85.8% total 90.7%)
    Net I/O: 425.8 KB/s (3.5*10^6 bps)

## Jellyfish 0.8

Command:

    ./bin/siege-jellyfish

Result:

    httperf --hog --timeout=60 --client=0/1 --server=localhost --port=8080 --uri=/jellyfish --rate=100 --send-buffer=4096 --recv-buffer=16384 --num-conns=1000 --num-calls=10 --burst-length=2
    Maximum connect burst length: 1

    Total: connections 1000 requests 10000 replies 10000 test-duration 11.679 s

    Connection rate: 85.6 conn/s (11.7 ms/conn, <=165 concurrent connections)
    Connection time [ms]: min 4.6 avg 1023.1 max 2287.6 median 1082.5 stddev 570.4
    Connection time [ms]: connect 0.0
    Connection length [replies/conn]: 10.000

    Request rate: 856.2 req/s (1.2 ms/req)
    Request size [B]: 71.0

    Reply rate [replies/s]: min 850.1 avg 853.6 max 857.2 stddev 5.1 (2 samples)
    Reply time [ms]: response 202.0 transfer 0.0
    Reply size [B]: header 142.0 content 422.0 footer 0.0 (total 564.0)
    Reply status: 1xx=0 2xx=10000 3xx=0 4xx=0 5xx=0

    CPU time [s]: user 0.99 system 9.63 (user 8.5% system 82.5% total 90.9%)
    Net I/O: 530.9 KB/s (4.3*10^6 bps)
