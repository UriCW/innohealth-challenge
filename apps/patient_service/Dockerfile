FROM node:latest
WORKDIR /srv
COPY package.json package-lock.json ./
RUN npm install 
COPY . .
RUN npx prisma generate
EXPOSE 3000
# CMD npm run start:compose
CMD npm run start
