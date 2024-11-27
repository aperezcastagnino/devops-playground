FROM node:20.9.0 AS builder

WORKDIR /home/api

COPY *.json ./

RUN npm install --production --pure-lockfile --ignore-scripts

COPY . .

EXPOSE 8000

CMD ["npm", "start"]
