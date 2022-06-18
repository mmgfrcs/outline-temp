ARG APP_PATH=/opt/outline
FROM node:16.14.2-alpine3.15

ARG APP_PATH
WORKDIR $APP_PATH

# ---
# Build
COPY ./package.json ./yarn.lock ./tmp/

RUN cd tmp && yarn install --no-optional --frozen-lockfile --network-timeout 1000000 && \
  yarn cache clean

COPY . ./tmp/
ARG CDN_URL
RUN cd tmp && yarn build

RUN rm -rf tmp/node_modules

RUN cd tmp && yarn install --production=true --frozen-lockfile --network-timeout 1000000 && \
  yarn cache clean

# Run
ENV NODE_ENV production

RUN cp ./tmp/build ./tmp/server ./tmp/public ./tmp/.sequelizerc ./tmp/node_modules ./tmp/package.json ./ && rm -rf tmp

RUN addgroup -g 1001 -S nodejs && \
  adduser -S nodejs -u 1001 && \
  chown -R nodejs:nodejs $APP_PATH/build

USER nodejs

EXPOSE 3000
CMD ["yarn", "start"]
