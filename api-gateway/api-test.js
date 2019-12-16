const axios = require("axios");
const { URLSearchParams } = require("url");

axios.defaults.baseURL = "http://localhost:3000";

const where = {
  where: {
    price: 100
  }
};

const apiPath = new URLSearchParams("/lottery-data");
// apiPath.append("where", JSON.stringify(where));
// console.log(apiPath.toString());

(async () => {
  try {
    const { data } = await axios.get(`/devices/123456`);
    console.log(data);
    return data;
  } catch (error) {
    console.log(error.response.status);
    if (error.response.status === 404) {
      const { data } = await axios.post(`/devices`, { id: "123456" });
      return data;
    }
    return new Error("something wrong");
  }
})();
