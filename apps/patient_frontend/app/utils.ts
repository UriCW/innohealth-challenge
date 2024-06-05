import { GoogleAuth } from 'google-auth-library'

export async function getIdentityToken(){
  if (!process.env.TARGET_AUDIENCE){
    throw Error("Environment variable TARGET_AUDIENCE must be set to get google identity token");
  }

  const auth = new GoogleAuth();
  const client = await auth.getIdTokenClient(process.env.TARGET_AUDIENCE)
  const clientHeaders = await client.getRequestHeaders();
  console.log(clientHeaders)
  return clientHeaders
}

export async function getHeaders() {
}
