curl -X PUT "http://127.0.0.1:32323/api/v1/telescope/0/connected" -H "accept: application/json" -H "Content-Type: application/x-www-form-urlencoded" -d "Connected=true&ClientID=0&ClientTransactionID=0"
curl -X GET "http://127.0.0.1:32323/api/v1/telescope/0/connected?ClientID=1&ClientTransactionID=1234" -H "accept: application/json"
