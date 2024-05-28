import express from "express";
import apicache from "apicache";
import { getAllRecords, updateRecords, seedDatabase } from './utils'
import 'dotenv/config'

const app = express();
let cache = apicache.middleware;
app.use(cache("1 minutes"));

const port = process.env.SERVICE_PORT || 8080;
const endpoint = process.env.ENDPOINT_URL || ""

if (!endpoint){
  throw new Error("Environment variable ENDPOINT_URL not defined, quitting");
}

app.get("/update", async (_, response) => {
  console.log("Updating records");
  updateRecords(endpoint).then(() => {
    response.send({ status: "SUCCESS", message: "Updated patient reading records on database" });
  });

});

app.get("/all", async (_, response) => {
  const allRecords = await getAllRecords()
  console.log("Getting all records");
  response.send(allRecords);
});

app.listen(port, () => {
  seedDatabase(endpoint);
  console.log(`Server is running on http://localhost:${port}`);
});
