// import { PrismaClient } from "@prisma/client";
// import { getAllRecords, numberOfClientsInDatabase, seedDatabase } from "../../utils"
describe("Test functions in utils.ts", () => {
  test("Placeholder for test", () => {
    expect(1).toBe(1)
  })
})
// // import axios from "axios";
// // jest.mock('axios')
// // const mockedAxios = axios as jest.Mocked<typeof axios>
// 
// describe("Tests utils", () => {
//   test("Number of clients on database", async() =>{
//     const num = await numberOfClientsInDatabase()
//     console.log(num)
//   })
// 
// 
//   test("Test seed", async() => {
//     seedDatabase("https://mockapi-furw4tenlq-ez.a.run.app/data")
//   })
//   test("Test get all records from database", async () => {
//     const mockRecords = [
//       {
//         id: 1,
//         name: "Record 1",
//         date_testing: new Date(),
//         date_birthdate: new Date(),
//       },
//     ];
//     const prismaClientMock = {
//       patientRecord: {
//         findMany: jest.fn().mockResolvedValue(mockRecords), // Mock prisma.patientRecord.findMany
//       },
//     };
//     const prismaSpy = jest
//       .spyOn(PrismaClient.prototype, "$connect")
//       .mockReturnValue(prismaClientMock as any);
// 
//     const allRecords = await getAllRecords(); // Call the function to test
//     console.log(allRecords);
// 
//     // Assert that prisma.patientRecord.findMany was called with the correct orderBy clause
//     expect(prismaClientMock.patientRecord.findMany).toHaveBeenCalledWith({
//       orderBy: { date_testing: "asc" },
//     });
// 
//     // Assert the return value of getAllRecords
//     expect(allRecords).toEqual(mockRecords);
// 
//     prismaSpy.mockRestore(); // Restore the original PrismaClient prototype
//   });
// });
