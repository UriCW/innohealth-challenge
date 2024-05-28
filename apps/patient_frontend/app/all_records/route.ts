import { NextResponse } from "next/server";
import "dotenv/config";

const endpoint = process.env.SERVICE_ENDPOINT;
export async function GET() {
  try {
    const response = await fetch(endpoint);
    const ret = await response.json();
    return NextResponse.json(ret);
  } catch (error) {
    console.error(error);
    return NextResponse.json({message: "Error getting records from service"});
  }
}
