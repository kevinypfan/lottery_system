// import { URLSearchParams } from "url";
function delay(ms) {
  return new Promise(function(resolve, reject) {
    setTimeout(function() {
      resolve();
    }, ms);
  });
}
export default {
  Query: {
    lotteryDatas: async (root, args, ctx) => {
      try {
        const { data } = await ctx.axios.get(
          "/lottery-data?filter=" + JSON.stringify(args)
        );
        await delay(2000);
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
