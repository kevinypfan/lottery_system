// import { URLSearchParams } from "url";

export default {
  Query: {
    trustees: async (root, args, ctx) => {
      try {
        const { data } = await ctx.axios.get(
          "/trustees?filter=" + JSON.stringify(args)
        );
        return data;
      } catch (error) {
        console.log(error);
        return new Error(error);
      }
    }
  }
};
