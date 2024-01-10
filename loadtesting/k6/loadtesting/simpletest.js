import http from "k6/http";
export let option = {
  insecureSkipTLSVerify: true,
  noConnectionReuse: true,
  vus: 1,
  duration: "18s",
};

export default () => {
  http.get("https://ssm.bougainvillea.live/dkaouelaauelajdilqjdgiiejd/");
};
