FROM node:latest
WORKDIR /srv
COPY package.json package-lock.json ./
RUN npm install
COPY . .
# This fails since SERVICE_ENDPOINT is not available at build time
# RUN npm run build
EXPOSE 3000
# hack builds and starts the service at runtime
CMD [ "npm", "run", "hack" ]

