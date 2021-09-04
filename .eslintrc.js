module.exports = {
  env: {
    browser: true,
    es2021: true,
    jquery: true,
    jest: true,
    node: true,
  },
  extends: [
    "plugin:react/recommended",
    "eslint:recommended", "plugin:import/recommended"
  ],
  "overrides": [
    {
      "files": "**/*.svelte",
      "processor": "svelte3/svelte3"
    }
  ],
  parserOptions: {
    ecmaFeatures: {
      jsx: true,
    },
    ecmaVersion: 12,
    sourceType: "module",
  },
  plugins: [
    "react", "import", "svelte3"
  ],
  rules: {
  },
};
