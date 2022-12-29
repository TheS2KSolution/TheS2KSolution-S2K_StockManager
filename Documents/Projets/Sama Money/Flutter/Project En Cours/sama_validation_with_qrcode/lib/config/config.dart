// const String baseUrl = "http://127.0.0.1:8000/subscribe/all";
// const baseUrl = "http://10.0.2.2:9090";
//const baseUrl = "http://127.0.0.1:8080/api/v1/";
const baseUrl = "http://192.168.137.1:8080/api/v1/";
const testToken =
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0Iiwic2NvcGVzIjoiUk9MRV9BRE1JTiIsImlhdCI6MTY3MTU2Mjc0OSwiZXhwIjoxNzAzOTYyNzQ5fQ.7kTDVOdEgLNOEEovN8lqh8ChxZgQZQBU7luqzKtIMnE";
const Map<String, String> headers = {
  "content-Type": "application/json",
  "Authorization": 'Bearer $testToken'
};
