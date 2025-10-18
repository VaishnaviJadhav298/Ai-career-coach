-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "clerkUserId" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT,
    "imageUrl" TEXT,
    "industry" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "bio" TEXT,
    "experience" INTEGER,
    CONSTRAINT "User_industry_fkey" FOREIGN KEY ("industry") REFERENCES "IndustryInsight" ("industry") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "UserSkill" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "userId" TEXT NOT NULL,
    "skill" TEXT NOT NULL,
    CONSTRAINT "UserSkill_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Assessment" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "userId" TEXT NOT NULL,
    "quizScore" REAL NOT NULL,
    "questions" JSONB NOT NULL,
    "category" TEXT NOT NULL,
    "improvementTip" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Assessment_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Resume" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "userId" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "atsScore" REAL,
    "feedback" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Resume_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "CoverLetter" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "userId" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "jobDescription" TEXT,
    "companyName" TEXT NOT NULL,
    "jobTitle" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'draft',
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "CoverLetter_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "IndustryInsight" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "industry" TEXT NOT NULL,
    "growthRate" REAL NOT NULL,
    "demandLevel" TEXT NOT NULL,
    "marketOutlook" TEXT NOT NULL,
    "lastUpdated" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "nextUpdate" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "IndustrySalaryRange" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "industryId" TEXT NOT NULL,
    "role" TEXT NOT NULL,
    "min" REAL NOT NULL,
    "max" REAL NOT NULL,
    "median" REAL NOT NULL,
    "location" TEXT,
    CONSTRAINT "IndustrySalaryRange_industryId_fkey" FOREIGN KEY ("industryId") REFERENCES "IndustryInsight" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "IndustryTopSkill" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "industryId" TEXT NOT NULL,
    "skill" TEXT NOT NULL,
    CONSTRAINT "IndustryTopSkill_industryId_fkey" FOREIGN KEY ("industryId") REFERENCES "IndustryInsight" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "IndustryKeyTrend" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "industryId" TEXT NOT NULL,
    "trend" TEXT NOT NULL,
    CONSTRAINT "IndustryKeyTrend_industryId_fkey" FOREIGN KEY ("industryId") REFERENCES "IndustryInsight" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "IndustryRecommendedSkill" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "industryId" TEXT NOT NULL,
    "skill" TEXT NOT NULL,
    CONSTRAINT "IndustryRecommendedSkill_industryId_fkey" FOREIGN KEY ("industryId") REFERENCES "IndustryInsight" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "User_clerkUserId_key" ON "User"("clerkUserId");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE INDEX "Assessment_userId_idx" ON "Assessment"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Resume_userId_key" ON "Resume"("userId");

-- CreateIndex
CREATE INDEX "CoverLetter_userId_idx" ON "CoverLetter"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "IndustryInsight_industry_key" ON "IndustryInsight"("industry");

-- CreateIndex
CREATE INDEX "IndustryInsight_industry_idx" ON "IndustryInsight"("industry");
