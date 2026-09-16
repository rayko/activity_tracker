import { resolve } from 'path'
import { defineConfig } from 'vite'
import tailwindcss from "@tailwindcss/vite";
import RubyPlugin from 'vite-plugin-ruby'

export default defineConfig({
  resolve: {
    alias: {
      '@assets': resolve(import.meta.dirname, 'app/assets'),
      '@controllers': resolve(import.meta.dirname, 'app/javascript/controllers')
    },
  },
  plugins: [
    RubyPlugin(),
    tailwindcss()
  ],
})
