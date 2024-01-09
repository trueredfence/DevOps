import http from "k6/http";
import { sleep } from "k6";
export const options = {
  insecureSkipTLSVerify: true,
  noConnectionReuse: true,
  stages: [
    { duration: "10s", target: 100 },
    { duration: "1m", target: 100 },
    { duration: "10s", target: 1500 },
    { duration: "3m", target: 1500 },
    { duration: "10s", target: 100 },
    { duration: "3m", target: 100 },
    { duration: "10s", target: 0 },
  ],
};
const API_URL = "https://ssm.bougainvillea.live";
export default () => {
  http.batch([["GET", `${API_URL}/dkaouelaauelajdilqjdgiiejd`]]);
  sleep(1);
};
