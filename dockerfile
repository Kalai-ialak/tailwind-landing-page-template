# Step 1: Base Image
FROM node:20-alpine AS base
WORKDIR /app
COPY package*.json ./

# Step 2: Dependencies
FROM base AS deps
RUN npm install

# Step 3: Development Stage
FROM base AS dev
COPY --from=deps /app/node_modules ./node_modules
COPY . .
# Tailwind live-ah run aaga port 3000 (standard for Vite/React)
EXPOSE 3000
CMD ["npm", "run", "dev"]

# Step 4: Build Stage (Production)
FROM base AS build
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

# Step 5: Production Stage (Using Nginx)
FROM nginx:alpine AS prod
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
