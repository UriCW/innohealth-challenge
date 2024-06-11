import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";
import React from "react";
import { UserProvider } from "@auth0/nextjs-auth0/client";

const inter = Inter({ subsets: ["latin"] });

export const metadata: Metadata = {
  title: "InoHealth Exercise",
  description: "A sample application",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html>
      <UserProvider loginUrl="/api/auth/login" profileUrl="/api/auth/me">
        <body className={inter.className}>
          <h1> BioComposition </h1>
          {children}
        </body>
      </UserProvider>
    </html>
  );
}
