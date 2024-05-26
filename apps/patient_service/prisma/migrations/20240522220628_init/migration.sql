-- CreateTable
CREATE TABLE "PatientRecord" (
    "id" SERIAL NOT NULL,
    "client_id" TEXT NOT NULL,
    "date_testing" TIMESTAMP(3) NOT NULL,
    "date_birthdate" TIMESTAMP(3) NOT NULL,
    "gender" INTEGER NOT NULL,
    "ethnicity" INTEGER NOT NULL,
    "creatine" DOUBLE PRECISION NOT NULL,
    "chloride" DOUBLE PRECISION NOT NULL,
    "fasting_glucose" DOUBLE PRECISION NOT NULL,
    "potassium" DOUBLE PRECISION NOT NULL,
    "sodium" DOUBLE PRECISION NOT NULL,
    "total_calcium" DOUBLE PRECISION NOT NULL,
    "total_protein" DOUBLE PRECISION NOT NULL,
    "creatine_unit" TEXT NOT NULL,
    "chloride_unit" TEXT NOT NULL,
    "fasting_glucose_unit" TEXT NOT NULL,
    "potassium_unit" TEXT NOT NULL,
    "sodium_unit" TEXT NOT NULL,
    "total_calcium_unit" TEXT NOT NULL,
    "total_protein_unit" TEXT NOT NULL,

    CONSTRAINT "PatientRecord_pkey" PRIMARY KEY ("id")
);
