module.exports = {
  apps: [
    {
      name: "study-frontend",
      cwd: "./frontend",
      script: "start.sh",
      interpreter: "bash",
      env: {
        NODE_ENV: "production",
        PORT: 3002,
        HOSTNAME: "0.0.0.0",
      },
    },
  ],
};
