go build client.go
for i in {1..1000}
do
    echo "Running client ${i}"
    sleep 0.005
    ./client &
done
