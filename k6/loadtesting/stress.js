import http from "k6/http";
import { sleep } from "k6";
export const options = {
  insecureSkipTLSVerify: true,
  noConnectionReuse: true,
  stages: [
    { duration: "2m", target: 100 },
    { duration: "5m", target: 100 },
    { duration: "2m", target: 200 },
    { duration: "5m", target: 200 },
    { duration: "2m", target: 300 },
    { duration: "5m", target: 300 },
    { duration: "2m", target: 400 },
    { duration: "5m", target: 400 },
    { duration: "10m", target: 0 },
  ],
};
const API_URL = "https://ssm.bougainvillea.live";
export default () => {
  http.batch([["GET", `${API_URL}/dkaouelaauelajdilqjdgiiejd`]]);
  sleep(1);
};
