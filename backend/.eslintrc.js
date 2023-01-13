/* eslint-disable */

const { readFileSync } = require("fs");

const generalRules = {
  "default-case": "off",
  "no-plusplus": "off",
  "no-continue": "off",
  "prefer-template": "off",
  "prefer-destructuring": "off",
  "class-methods-use-this": "off",

  // Allow leading underscores in identifiers (e.g. _id in MongoDB).
  "no-underscore-dangle": "off",

  // Some APIs use snake_case identifiers.
  camelcase: "off",

  // Depending on the context, using bracket notation might be clearer.
  "dot-notation": "off",

  /**
   * Reassigning parameters can be useful to avoid creating another variable,
   * and to modify objects by reference.
   */
  "no-param-reassign": "off",

  /**
   * Unused variables and arguments should be removed in most cases, but it's
   * convenient to allow them when the code is still being implemented.
   *
   * Prefix variable names with an underscore to suppress the warning.
   */
  "no-unused-vars": [
    "warn",
    {
      argsIgnorePattern: "^_",
      varsIgnorePattern: "^_",
    },
  ],

  // Not necessary for some APIs (consistency reasons)
  "import/prefer-default-export": "off",

  // Stylistic rules.
  "lines-between-class-members": "off",
};

const reactRules = {
  "react/jsx-filename-extension": "off",
  "react/prop-types": "off",
  "react/destructuring-assignment": "off",

  // Allow prop spreading, but require explicit spreading for HTML tags.
  "react/jsx-props-no-spreading": [
    2,
    { html: "enforce", custom: "ignore", explicitSpread: "ignore" },
  ],

  // Use warnings instead of errors for issues that aren't deal-breakers.
  "react/sort-comp": "warn",
  "react/prefer-stateless-function": "warn",
  "react/no-array-index-key": "warn",
};

/**
 * Override rules from eslint-plugin-jsx-a11y, if present.
 */
function getAccessibilityOverrideRules() {
  let a11yRules;
  try {
    a11yRules = require("eslint-plugin-jsx-a11y").rules;
  } catch (e) {
    return {};
  }

  const newRules = {};

  // Produce warnings instead of errors for accessibility problems.
  Object.keys(a11yRules).forEach((name) => {
    newRules[`jsx-a11y/${name}`] = "warn";
  });

  return newRules;
}

/**
 * Override rules from eslint-config-airbnb-base, if present.
 */
function getAirbnbOverrideRules() {
  let airbnbRules;
  try {
    airbnbRules = require("eslint-config-airbnb-base/rules/style.js").rules;
  } catch (e) {
    return {};
  }

  return {
    // Allow the use of for...of statements.
    "no-restricted-syntax": airbnbRules["no-restricted-syntax"].filter(
      (item) => item.selector !== "ForOfStatement"
    ),
  };
}

/**
 * Load the .eslintrc.json file, which contains frontend/backend-specific configuration.
 */
function loadEslintrcJson() {
  const path = ".eslintrc.json";

  let data;
  try {
    data = readFileSync(path, "utf8");
  } catch (e) {
    throw new Error(`File '${path}' does not exist.`);
  }

  try {
    return JSON.parse(data);
  } catch (e) {
    throw new Error(`Syntax error in '${path}': ${e.message}`);
  }
}

/**
 * Generate the complete rules object.
 */
function generateRules(usingReact, usingNode) {
  const rules = { ...generalRules };
  Object.assign(rules, getAirbnbOverrideRules());
  if (usingReact) {
    Object.assign(rules, reactRules);
    Object.assign(rules, getAccessibilityOverrideRules());
  }
  if (usingNode) {
    // Allow console.log and friends in the backend.
    rules["no-console"] = "off";
  }
  return rules;
}

/**
 * Generate the ESLint configuration.
 */
function generateConfig() {
  if (process.env.NODE_ENV === "production") {
    // Disable linting in production, since it is unnecessary and can cause
    // errors if dev dependencies are not installed.
    return {};
  }

  const eslintrcJson = loadEslintrcJson();
  const usingReact = eslintrcJson.plugins !== undefined && eslintrcJson.plugins.includes("react");
  const usingNode = eslintrcJson.env.node;
  const usingTypeScript =
    eslintrcJson.plugins !== undefined && eslintrcJson.plugins.includes("@typescript-eslint");

  const config = {
    settings: {
      react: {
        version: "detect",
      },
    },
    ...eslintrcJson,
    extends: [
      ...eslintrcJson.extends,
      usingReact ? "airbnb" : "airbnb-base",
      ...(usingTypeScript ? [usingReact ? "airbnb-typescript" : "airbnb-typescript/base"] : []),
      "prettier",
    ],
    rules: {
      ...generateRules(usingReact, usingNode),
      ...eslintrcJson.rules,
    },
  };

  if (usingReact) {
    config.parser = "@babel/eslint-parser";
    config.parserOptions.requireConfigFile = false;
    config.parserOptions.babelOptions = { plugins: ["@babel/plugin-syntax-jsx"] };
  }

  return config;
}

module.exports = generateConfig();
