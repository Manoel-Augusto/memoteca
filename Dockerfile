FROM node:latest as angular
WORKDIR /app
COPY package*.json .
RUN npm install --silent
COPY . .
RUN npm run build

FROM nginx:alpine
VOLUME /var/cache/nginx
COPY --from=angular /app/dist/memoteca/ /usr/share/nginx/html
COPY ./config/nginx.conf /etc/nginx/conf.d/default.conf

#docker build -t imgTest-memoteca .
# docker run -p 8081:80 imgTest-memoteca
