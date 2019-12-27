// import { URLSearchParams } from "url";

export default {
  Query: {
    lotteryDatas: async (root, args, ctx) => {
      try {
        const { data } = await ctx.axios.get(
          "/lottery-data?filter=" + JSON.stringify(args)
        );
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
  },
  Mutation: {
    newLotteryItem: async (root, args, ctx) => {
      try {
        console.log({ ...args.input });
        const { data } = await ctx.axios.post(`/lottery-items`, {
          ...args.input,
          createdAt: new Date().toISOString()
        });

        return data;
      } catch (error) {
        console.log(error);
        if (error.response.status === 500) {
          const filter = {
            where: {
              serial: args.input.serial
            }
          };
          const { data } = await ctx.axios.get(
            `/lottery-items?filter=${JSON.stringify(filter)}`
          );
          console.log(data);
          if (data.length > 0) {
            return new Error("database already have this item!");
          }
        }
        return new Error(error);
      }
    }
  }
};
