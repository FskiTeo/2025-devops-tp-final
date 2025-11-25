FROM node:20-alpine AS builder
WORKDIR /app

COPY package.json package-lock.json* ./

RUN npm install
RUN npm install @storybook/cli -g

COPY . .

RUN npm run build-storybook

FROM nginx:alpine AS production

WORKDIR /usr/share/nginx/html

COPY --from=builder /app/storybook-static .
RUN ls -la .

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]