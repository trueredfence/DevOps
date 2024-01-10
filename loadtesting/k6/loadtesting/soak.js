import http from "k6/http";
import { sleep } from "k6";
export const options = {
  insecureSkipTLSVerify: true,
  noConnectionReuse: true,
  stages: [
    { duration: "2m", target: 400 },
    { duration: "1h30m", target: 400 },
    { duration: "2m", target: 0 },
  ],
};
const API_URL = "https://ssm.bougainvillea.live";
export default () => {
  http.batch([["GET", `${API_URL}/dkaouelaauelajdilqjdgiiejd`]]);
  sleep(1);
};
