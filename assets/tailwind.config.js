// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const plugin = require("tailwindcss/plugin");
const fs = require("fs");
const path = require("path");

module.exports = {
  content: ["./js/**/*.js", "../lib/*_web.ex", "../lib/*_web/**/*.*ex"],
  theme: {
    extend: {
      colors: {
        // Define your custom colors here
        main: {
          100: "#BFCEFF", // Light shade
          200: "#A3AFD9",
          300: "#8296D2",
          400: "#7182B6",
          500: "#5F6D98", // Base color
          600: "#4E577B",
          700: "#3C435F",
          800: "#2A2F43",
          900: "#292f42", // Dark shade
        },
      },
      minHeight: {
        page: "calc(100vh - 150px)",
      },
    },
    keyframes: {
      "message-move-1": {
        "0%": { transform: "translateX(-2%) translateY(0%)" },
        "50%": { transform: "translateX(1%) translateY(0%)" },
        "100%": { transform: "translateX(-2%) translateY(0%)" },
      },
      "message-move-2": {
        "0%": { transform: "translateX(1%) translateY(0%)" },
        "50%": { transform: "translateX(-2%) translateY(1%)" },
        "100%": { transform: "translateX(1%) translateY(0%)" },
      },
      "message-move-3": {
        "0%": { transform: "translateX(0%) translateY(2%)" },
        "50%": { transform: "translateX(0%) translateY(-1%)" },
        "100%": { transform: "translateX(0%) translateY(2%)" },
      },
    },

    animation: {
      "message-move-1": "message-move-1 3s ease-in-out infinite",
      "message-move-2": "message-move-2 3s ease-in-out infinite",
      "message-move-3": "message-move-3 3s ease-in-out infinite",
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    // Allows prefixing tailwind classes with LiveView classes to add rules
    // only when LiveView classes are applied, for example:
    //
    //     <div class="phx-click-loading:animate-ping">
    //
    plugin(({ addVariant }) =>
      addVariant("phx-no-feedback", [".phx-no-feedback&", ".phx-no-feedback &"])
    ),
    plugin(({ addVariant }) =>
      addVariant("phx-click-loading", [
        ".phx-click-loading&",
        ".phx-click-loading &",
      ])
    ),
    plugin(({ addVariant }) =>
      addVariant("phx-submit-loading", [
        ".phx-submit-loading&",
        ".phx-submit-loading &",
      ])
    ),
    plugin(({ addVariant }) =>
      addVariant("phx-change-loading", [
        ".phx-change-loading&",
        ".phx-change-loading &",
      ])
    ),

    // Embeds Heroicons (https://heroicons.com) into your app.css bundle
    // See your `CoreComponents.icon/1` for more information.
    //
    plugin(function ({ matchComponents, theme }) {
      let iconsDir = path.join(__dirname, "./vendor/heroicons/optimized");
      let values = {};
      let icons = [
        ["", "/24/outline"],
        ["-solid", "/24/solid"],
        ["-mini", "/20/solid"],
      ];
      icons.forEach(([suffix, dir]) => {
        fs.readdirSync(path.join(iconsDir, dir)).map((file) => {
          let name = path.basename(file, ".svg") + suffix;
          values[name] = { name, fullPath: path.join(iconsDir, dir, file) };
        });
      });
      matchComponents(
        {
          hero: ({ name, fullPath }) => {
            let content = fs
              .readFileSync(fullPath)
              .toString()
              .replace(/\r?\n|\r/g, "");
            return {
              [`--hero-${name}`]: `url('data:image/svg+xml;utf8,${content}')`,
              "-webkit-mask": `var(--hero-${name})`,
              mask: `var(--hero-${name})`,
              "mask-repeat": "no-repeat",
              "background-color": "currentColor",
              "vertical-align": "middle",
              display: "inline-block",
              width: theme("spacing.5"),
              height: theme("spacing.5"),
            };
          },
        },
        { values }
      );
    }),
  ],
};
