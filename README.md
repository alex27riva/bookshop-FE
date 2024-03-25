# bookshop_fe

Online bookshop frontend written in Flutter

## Configuration

Create a `.env` file in the `assets/` folder with the following content:

```ini
CLIENT_ID=flask-demo
REDIRECT_URI_SCHEME=http
REDIRECT_URI_PATH=localhost:8000/redirect
AUTH_ENDPOINT_URI=http://localhost:8080/realms/unimi/protocol/openid-connect/auth
BACKEND_CALLBACK_URI=http://localhost:5000/auth/callback
```

## Run

`flutter run -d chrome --web-renderer html --web-port=8000
`
