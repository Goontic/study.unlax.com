module.exports = {
  apps: [
    {
      name: "study-frontend",
      cwd: "./frontend",
      script: "node_modules/.bin/next",
      args: "start",
      env: {
        NODE_ENV: "production",
        PORT: 3000,
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
