module.exports = {
  content: ["../lib/*_web/**/*.*ex", "../lib/**/*.sface", "./js/**/*.js"],
  theme: {
    extend: {
      fontFamily: {
        sans: ["Inter", "sans-serif"],
        "sans-secondary": ["F37Judge-bold", "sans-serif"],
      },
      fontSize: {
        base: ["1rem", "1.5"],
        lg: ["1.2rem", "1.5"],
        xl: ["1.4rem", "1.5"],
        "2xl": ["1.6rem", "1.5"],
        "3xl": ["1.8rem", "1.5"],
        "4xl": ["2.4rem", "1.5"],
        "5xl": ["3.2rem", "1.5"],
        "6xl": ["3.6rem", "1.5"],
        "8xl": ["6.8rem", "1.5"],
        "10vw": ["10vw"],
      },
      colors: {
        red: "#ff3059",
        orange: "#ff9330",
        yellow: "#fff799",
        "gray-100": "#f8f9fa",
        "gray-200": "#dfe4e6",
        "gray-300": "#c2c9cc",
        "gray-400": "#8a9499",
        "gray-700": "#5c6366",
        "blue-100": "#e2f4fd",
        "blue-400": "#0086e6",
        "blue-700": "#0039cf",
        "green-100": "#d4faed",
        "green-400": "#00e7bb",
        "green-700": "#009488",
        "red-700": "#b91c1c",
      },
      flex: {
        full: "0 0 100%",
      },
      opacity: {
        9: "0.09",
        15: "0.15",
      },
      zIndex: {
        "-1": "-1",
        1: "1",
        2: "2",
        3: "3",
      },
      cursor: {
        grabbing: "grabbing",
      },
      backgroundImage: (_theme) => ({
        "hero-sm": "url('../images/bg-hero-sm.svg')",
        "hero-lg": "url('../images/bg-hero-lg.svg')",
      }),
    },
  },
  plugins: [],
  corePlugins: {
    container: false,
  },
};
