module.exports = {
  apps: [
    {
      name: "study-frontend",
      cwd: "./frontend",
      script: "start.sh",
      interpreter: "bash",
      env: {
        NODE_ENV: "production",
        PORT: 3000,
        HOSTNAME: "0.0.0.0",
      },
    },
    {
      name: "study-backend",
      cwd: "./backend",
      script: "dist/main.js",
      env: {
        NODE_ENV: "production",
        PORT: 4000,
      },
    },
  ],
};
