import http from "k6/http";
import { sleep } from "k6";
export const options = {
  insecureSkipTLSVerify: true,
  noConnectionReuse: true,
  // Key configurations for breakpoint in this section
  executor: "ramping-arrival-rate", //Assure load increase if the system slows
  stages: [
    { duration: "2h", target: 20000 }, // just slowly ramp-up to a HUGE load
  ],
};
const API_URL = "https://ssm.bougainvillea.live";
export default () => {
  http.batch([["GET", `${API_URL}/dkaouelaauelajdilqjdgiiejd`]]);
  sleep(1);
};
