import { NextResponse } from "next/server";
import 'dotenv/config'

const endpoint = process.env.SERVICE_ENDPOINT
export async function GET(){
  const response = await fetch(endpoint);
  const ret = await response.json()
  return NextResponse.json(ret);
}
