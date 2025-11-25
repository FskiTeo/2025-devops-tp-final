FROM node:20-alpine AS builder
WORKDIR /app

COPY package.json package-lock.json* ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx:alpine AS production

WORKDIR /usr/share/nginx/html

COPY --from=builder /app/dist .
COPY nginx.conf.template /etc/nginx/conf.d/default.conf.template

RUN apk add --no-cache gettext

EXPOSE 5173

ENTRYPOINT [ "sh", "-c", "envsubst '${BACKEND_HOST} ${BACKEND_PORT}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'" ]