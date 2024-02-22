FROM node:20-alpine as base

RUN mkdir -p /usr/src/nuxt-app

RUN apk update && apk upgrade

FROM base as builder

WORKDIR /tmp/nuxt-app
COPY --link package.json package-lock.json ./

RUN npm install --save

FROM base

WORKDIR /usr/src/nuxt-app
COPY --from=builder /tmp/nuxt-app/node_modules ./node_modules
COPY . .

CMD [ "npm", "run", "dev" ]
