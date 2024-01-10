import http from "k6/http";
import { sleep } from "k6";
export const options = {
  insecureSkipTLSVerify: true,
  noConnectionReuse: true,
  stages: [
    { duration: "5m", target: 100 },
    { duration: "10m", target: 100 },
    { duration: "5m", target: 0 },
  ],
  thresholds: {
    http_req_failed: ["rate<0.01"], // http errors should be less than 1%
    http_req_duration: ["p(95)<200"], // 95% of requests should be below 200ms
  },
};
const API_URL = "https://ssm.bougainvillea.live";
export default () => {
  http.batch([["GET", `${API_URL}/dkaouelaauelajdilqjdgiiejd`]]);
  sleep(1);
};
