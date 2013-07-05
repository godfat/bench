
bench () {
  echo "Hitting $*"
  echo
  httperf --hog --server localhost --port 8080 --uri $* --num-calls 10 --burst-length 2 --num-conn 1000 --rate 100 --timeout 60
}
