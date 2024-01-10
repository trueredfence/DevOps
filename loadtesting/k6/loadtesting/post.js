import http from "k6/http";
const API_URL = "https://ssm.bougainvillea.live/login";
export default function () {
  const payload = JSON.stringify({
    email: "abc@gmail.com",
    password: "password",
  });

  const params = {
    headers: {
      "Content-Type": "application/json",
    },
  };

  http.post(API_URL, payload, params);
}
