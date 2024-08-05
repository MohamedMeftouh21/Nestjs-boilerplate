# Development Stage
FROM node:16 AS development

# Install curl
RUN apt-get update && apt-get install -y curl

WORKDIR /app

COPY package*.json ./

RUN npm install glob rimraf

RUN npm install --only=development

COPY . .

RUN npm run build

# Production Stage
FROM node:16 AS production

# Install curl
RUN apt-get update && apt-get install -y curl

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /app

COPY package*.json ./

RUN npm install --only=production

COPY . .

COPY --from=development /app/dist ./dist

CMD ["node", "dist/main"]
