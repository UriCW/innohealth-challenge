import {getIdentityToken} from "@/app/utils"
describe("Test token generating", ()=> {
  const OLD_ENV = process.env

  beforeEach( ()=>{
    jest.resetModules()
    process.env = { ...OLD_ENV };
  })

  afterAll( () => {
    process.env = OLD_ENV;

  })

  test("Placeholder for a test", ()=>{
    expect(1).toBe(1)
  })
});
