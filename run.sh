# Starts server and runs it silently (i.e no output in the terminal)
./laplace -tls -addr 0.0.0.0:8888 > /dev/null 2>&1 &
# Starts chromium browser and runs it silently (i.e no output in the terminal)
./laplace -headless -addr ${1} > /dev/null 2>&1 &
# Lets the script sleep for 2 seconds
sleep 2
# Gets roomInfo and stores in the tmp directory as JSON
./laplace -headless -roomInfo > /tmp/output.txt
# Gets the room ID from the JSON file and outputs to tmp directory as text
jq .id /tmp/output.txt > /tmp/test.txt
# Gets roomID from tmp directory as text
roomID=$(cat /tmp/test.txt)
# remove " from string
roomID=$(echo "$roomID" | tr -d '"')

# Checks if the IP address is a IPV6 or IPV4 address
if [ "$1" != "${1#*[0-9].[0-9]}" ]; then
  echo "https://"${1}":8888/?roomID="${roomID}
elif [ "$1" != "${1#*:[0-9a-fA-F]}" ]; then
  echo "https://["${1}"]:8888/?roomID="${roomID}
else
  echo "Unrecognized IP format '$1'"
fi





