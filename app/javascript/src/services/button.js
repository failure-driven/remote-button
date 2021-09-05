const SERVER_URL = process.env.API_HOST_URL || "http://localhost:3000";

const getButton = ({ buttonId }) => {
  return buttonAction({
    actino: "GET",
    url: `${SERVER_URL}/buttons/${buttonId}.json`,
  });
};
const pressButton = ({ buttonId }) => {
  return buttonAction({
    action: "POST",
    url: `${SERVER_URL}/buttons/${buttonId}/event`,
  });
};

export default async function buttonAction({ action, url }) {
  const headers = {
    "Content-Type": "application/json",
  };
  const response = await fetch(url, {
    method: action,
    headers,
  });
  if (!response.ok) throw new Error(await response.text());
  return response;
}

export { getButton, pressButton };
