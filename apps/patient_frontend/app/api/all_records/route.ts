import { NextResponse, NextRequest } from "next/server";
import "dotenv/config";

export const dynamic = "force-dynamic";
const endpoint = process.env.SERVICE_ENDPOINT;
export async function GET(req: NextRequest) {
  try {
    console.log("url", req.url);
    const response = await fetch(endpoint, { next: { revalidate: 60} });
    const ret = await response.json();
    return NextResponse.json(ret);
  } catch (error) {
    console.error(error);
    return NextResponse.json({message: "Error getting records from service"}, { status: 500 });
  }
}
