# Base Image
FROM node:20-alpine
WORKDIR /app

# Dependencies install panrathu
COPY package*.json ./
RUN npm install

# Source code-ai copy panrathu
COPY . .

# Vite/React standard port
EXPOSE 3000

# Dev server start panna
CMD ["npm", "run", "dev"]
