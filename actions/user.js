"use server";

import { db } from "@/lib/prisma";
import { generateAIInsights } from "./dashboard";
import { checkAuth } from "@/lib/checkAuth";

export async function updateUser(data) {
  try {
    const user = await checkAuth();

    const result = await db.$transaction(
      async (tx) => {
        // Check if the industry insight already exists
        let industryInsight = await tx.industryInsight.findUnique({
          where: {
            industry: data.industry,
          },
        });

        // If not, generate and create industry insight
        if (!industryInsight) {
          const insights = await generateAIInsights(data.industry);

          industryInsight = await tx.industryInsight.create({
            data: {
              industry: data.industry,
              salaryRanges: {
                create: insights.salaryRanges, // Array of objects with role, min, max, median, location
              },
              topSkills: {
                create: insights.topSkills.map((skill) => ({ skill })),
              },
              keyTrends: {
                create: insights.keyTrends.map((trend) => ({ trend })),
              },
              recommendedSkills: {
                create: insights.recommendedSkills.map((skill) => ({ skill })),
              },
              growthRate: insights.growthRate,
              demandLevel: insights.demandLevel,
              marketOutlook: insights.marketOutlook,
              nextUpdate: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000), // 7 days later
            },
          });
        }

        // Update the user with selected industry and profile data
        const updatedUser = await tx.user.update({
          where: {
            id: user.id,
          },
          data: {
            industry: data.industry,
            experience: data.experience,
            bio: data.bio,
            skills: {
              deleteMany: {}, // clear previous skills
              create: data.skills.map((skill) => ({ skill })),
            },
          },
        });

        return { updatedUser, industryInsight };
      },
      {
        timeout: 10000, // in ms
      }
    );

    return { success: true, ...result };
  } catch (error) {
    console.log("Error updating user and industry: ", error.message);
    throw new Error("Failed to update profile");
  }
}

export async function getUserOnboardingStatus() {
  try {
    const user = await checkAuth();

    return {
      isOnboarded: !!user?.industryInsight,
    };
  } catch (error) {
    console.log("Error checking onboarding status: ", error.message);
    throw new Error("Failed to check onboarding status");
  }
}
