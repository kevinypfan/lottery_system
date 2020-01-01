export default {
  Query: {
    getStore: async (root, args, ctx) => {
      try {
        const { data } = await ctx.axios.get(`/stores/` + args.id);
        return data;
      } catch (error) {
        return new Error(error);
      }
    }
  },
  Mutation: {
    newStore: async (root, args, ctx) => {
      try {
        const { data } = await ctx.axios.post("/stores", { ...args.input });
        return data;
      } catch (error) {
        return new Error(error);
      }
    }
  }
};
