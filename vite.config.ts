import { resolve } from 'path'
import { defineConfig } from 'vite'
import tailwindcss from "@tailwindcss/vite";
import RubyPlugin from 'vite-plugin-ruby'

export default defineConfig({
  resolve: {
    alias: {
      '@assets': resolve(__dirname, 'app/assets'),
    },
  },
  plugins: [
    RubyPlugin(),
    tailwindcss()
  ],
})
