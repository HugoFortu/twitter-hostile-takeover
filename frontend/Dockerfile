FROM node:20-alpine as base

ENV APP /usr/src/nuxt-app
RUN mkdir -p ${APP}
WORKDIR ${APP}

RUN apk update && apk upgrade

FROM base as builder
COPY --link package.json package-lock.json ${APP}
RUN npm install

FROM base
COPY --from=builder ${APP}/node_modules ${APP}/node_modules

CMD [ "npm", "run", "dev" ]
