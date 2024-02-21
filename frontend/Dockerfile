FROM node:20-slim as base

ENV NODE_ENV=development

WORKDIR /src/app

# Build
FROM base as build

COPY --link package.json package-lock.json ./
RUN npm install

# Run
FROM base

COPY --from=build /src/app/node_modules /src/app/node_modules

CMD [ "npm", "run", "dev" ]
