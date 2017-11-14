// prettier-ignore
module.exports = {
    "env": {
        "browser": true,
        "es6": true
    },
    "extends": "eslint:recommended",
    "parserOptions": {
        "sourceType": "module",
          "ecmaFeatures": {
            "experimentalObjectRestSpread": true,
            "impliedStrict": true
          }
    },
    "rules": {
        "indent": [
            "error",
            2
        ],
        "linebreak-style": [
            "error",
            "unix"
        ],
        'quotes': [
          "error",
          'single',
          {avoidEscape: true, allowTemplateLiterals: true }
        ],
        "semi": [
            "warn",
            "never"
        ],
        "comma-dangle": [
          "warn",
          "only-multiline"
        ],
        "no-undef": [
          "warn"
        ],
        "prefer-spread": [
          "error"
        ],
        "no-unused-vars": [
          "error",
          {
            "argsIgnorePattern": "^_"
          }
      ]

    }
};
