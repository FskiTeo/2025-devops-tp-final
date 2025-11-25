FROM node:20-alpine AS builder
WORKDIR /app

COPY package.json package-lock.json* ./

RUN npm install

RUN npm install @storybook/cli -g

COPY . .

RUN npm run build

RUN npm run build-storybook

FROM nginx:alpine AS production

WORKDIR /usr/share/nginx/html

COPY --from=builder /app/dist ./frontend

COPY --from=builder /app/storybook-static ./storybook

COPY nginx.conf.template /etc/nginx/conf.d/default.conf.template

RUN apk add --no-cache gettext

EXPOSE 5173

ENTRYPOINT [ "sh", "-c", "envsubst '${BACKEND_HOST} ${BACKEND_PORT}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'" ]