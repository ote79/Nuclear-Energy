/** @type {import('tailwindcss').Config} */
export default {
  content: [
    './index.html',
    './src/**/*.{vue,js,ts,jsx,tsx}'
  ],
  theme: {
    extend: {
      colors: {
        primary: {
          50: '#e6f7f5',
          100: '#ccefec',
          200: '#99dfd9',
          300: '#66cfc6',
          400: '#33bfb3',
          500: '#00afa0',
          600: '#008c80',
          700: '#006960',
          800: '#004640',
          900: '#002320'
        },
        nuclear: {
          blue: '#1a73e8',
          green: '#0d9488',
          orange: '#f59e0b',
          red: '#ef4444',
          yellow: '#eab308'
        },
        'nuclear-blue': '#1a73e8'
      },
      fontFamily: {
        sans: ['"PingFang SC"', '"Microsoft YaHei"', 'sans-serif']
      },
      keyframes: {
        'pulse-glow': {
          '0%, 100%': { opacity: '0.4', transform: 'scale(1)' },
          '50%': { opacity: '0.8', transform: 'scale(1.5)' }
        }
      },
      animation: {
        'pulse-glow': 'pulse-glow 2s ease-in-out infinite'
      }
    }
  },
  plugins: []
}
