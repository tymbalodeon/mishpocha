FROM node as base
RUN npm install --global pnpm
WORKDIR /ui
COPY . .
RUN pnpm install

FROM base as dev
WORKDIR /ui
CMD ["pnpm", "dev", "--host"]

FROM base as prod
WORKDIR /ui
RUN pnpm build
CMD ["node", "server/entry.express"]
