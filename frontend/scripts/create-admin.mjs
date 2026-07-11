import { PrismaClient } from "@prisma/client";
import { PrismaPg } from "@prisma/adapter-pg";
import bcrypt from "bcryptjs";
import * as readline from "readline/promises";

async function main() {
  const adapter = new PrismaPg({ connectionString: process.env.DATABASE_URL });
  const prisma = new PrismaClient({ adapter });

  const rl = readline.createInterface({ input: process.stdin, output: process.stdout });
  const email = process.argv[2] ?? (await rl.question("Admin email: "));
  const password = process.argv[3] ?? (await rl.question("Admin password: "));
  const displayName = process.argv[4] ?? (await rl.question("Display name: "));
  rl.close();

  const existing = await prisma.adminUser.findUnique({ where: { email } });
  if (existing) {
    console.error(`Admin with email ${email} already exists (id=${existing.id}).`);
    await prisma.$disconnect();
    process.exit(1);
  }

  const passwordHash = await bcrypt.hash(password, 10);
  const admin = await prisma.adminUser.create({
    data: { email, passwordHash, displayName },
  });
  console.log(`Created admin user: id=${admin.id} email=${admin.email}`);
  await prisma.$disconnect();
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
