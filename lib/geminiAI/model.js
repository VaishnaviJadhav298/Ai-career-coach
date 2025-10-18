import { GoogleGenerativeAI } from "@google/generative-ai";

// ✅ Use the correct environment variable name
const genAI = new GoogleGenerativeAI(process.env.GOOGLE_API_KEY);

export const model = genAI.getGenerativeModel({
  model: "gemini-1.5-flash",
});
