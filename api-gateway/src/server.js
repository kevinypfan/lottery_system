import "./config/config";
import express from "express";
import { ApolloServer } from "apollo-server-express";
import http from "http";
import morgan from "morgan";
import schema from "./schema";
import pubsub from "./utils/pubsub";
import axios from "./utils/axios";

const app = express();
app.use(morgan("dev"));

const context = async ({ req, res }) => {
  let ctx = { req, res, pubsub, axios };
  try {
    // const { user, token } = await authentication(req);
    // if (user) {
    //   ctx = { ...ctx, user, token };
    // }
    return ctx;
  } catch (err) {
    return ctx;
  }
};

const apolloServer = new ApolloServer({ schema, context, cors: true });
apolloServer.applyMiddleware({ app });

const server = http.createServer(app);

// Add subscription support
apolloServer.installSubscriptionHandlers(server);

server.listen({ port: process.env.PORT }, () => {
  console.log(
    "🚀 Server ready at",
    `${process.env.HOSTNAME}${apolloServer.graphqlPath}`
  );
});
