FROM node:latest AS base
RUN npm install --global pnpm
WORKDIR /ui
COPY ./ ./
RUN pnpm install

FROM base AS dev
WORKDIR /ui
CMD [ "pnpm", "dev", "--host" ]

FROM base AS prod
WORKDIR /ui
RUN pnpm build
CMD [ "node", "server/entry.express" ]
