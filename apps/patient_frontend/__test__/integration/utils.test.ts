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


  // test("Missing env TARGET_AUDIENCE throws an error", ()=>{
  //   const t = () => {
  //     getIdentityToken()
  //   }

  //   expect( t ).toThrow(TypeError);
  // })

  // test("Try to get the token", () =>{
  //   process.env.TARGET_AUDIENCE = "Wrong"
  //   const token = getIdentityToken()
  //   expect(1).toBe(1);
  // })
});
