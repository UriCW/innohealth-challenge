import axios from "axios";
import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

export async function updateRecords(endpoint: string) {
  console.log("updateRecords() called");
  const response = await axios.get(endpoint);
  for (var reading of response.data) {
    reading.date_testing = new Date(reading.date_testing);
    reading.date_birthdate = new Date(reading.date_birthdate);
    await prisma.patientRecord.create({ data: reading });
  }
}

export async function getAllRecords() {
  const allRecords = await prisma.patientRecord.findMany({
    orderBy: {
      date_testing: "asc",
    },
  });
  return allRecords;
}

export async function numberOfClientsInDatabase() {
  const n = await prisma.patientRecord.groupBy({
    by: "client_id"
  })
  return n.length
}


export async function seedDatabase(endpoint: string) {
  var numClients = await numberOfClientsInDatabase()
  while (numClients <= 10) {
    console.log(`Database contains ${numClients} seeding again`);
    numClients = await numberOfClientsInDatabase()
    await updateRecords(endpoint);
  }
}
