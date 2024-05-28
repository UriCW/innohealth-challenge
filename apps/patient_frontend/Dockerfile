FROM node:latest
WORKDIR /srv
COPY package.json package-lock.json ./
RUN npm install
COPY . .
# This fails since SERVICE_ENDPOINT is not available at build time
EXPOSE 3000
# RUN npm run build
# RUN next build --experimental-build-mode compile/generate
RUN npx next build --experimental-build-mode compile
# hack builds and starts the service at runtime
# CMD [ "npm", "run", "hack" ]
CMD [ "npm", "run", "start"]

