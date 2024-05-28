import { NextResponse } from "next/server";
export async function GET(){
  const response = await fetch("http://localhost:3000/all");
  const ret = await response.json()
  return NextResponse.json(ret);
}
