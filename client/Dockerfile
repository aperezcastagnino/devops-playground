FROM node:20.9.0 AS builder

WORKDIR /home/client

COPY *.json ./

RUN npm install --production --pure-lockfile --ignore-scripts

COPY . .

RUN npm run build

FROM nginx:alpine

COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /home/client/build /usr/share/nginx/html

EXPOSE 3000

CMD ["nginx", "-g", "daemon off;"]
