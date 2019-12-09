// import { URLSearchParams } from "url";
export default {
  Query: {
    lotteryDatas: async (root, args, ctx) => {
      try {
        const { data } = await ctx.axios.get("/lottery-data");
        return data;
      } catch (error) {
        console.log(error);
        return new Error(error);
      }
    },
    lotteryData: async (root, args, ctx) => {
      try {
        const { data } = await ctx.axios.get(`/lottery-data/${args.id}`);
        return data;
      } catch (error) {
        console.log(error);
        return new Error(error);
      }
    }
  }
};
