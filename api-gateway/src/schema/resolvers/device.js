export default {
  Query: {
    getDevice: async (root, args, ctx) => {
      try {
        const { data } = await ctx.axios.get(`/devices/` + args.id);
        return data;
      } catch (error) {
        return new Error(error);
      }
    }
  },
  Mutation: {
    newDevice: async (root, args, ctx) => {
      try {
        const { data } = await ctx.axios.post("/devices", { ...args.input });
        return data;
      } catch (error) {
        return new Error(error);
      }
    }
  }
};

// const { data } = await axios.post(`/devices`, { id: "123456" });
