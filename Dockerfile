FROM node:8 AS build

RUN mkdir -p /app
WORKDIR /app
COPY . /app 

RUN npm install --global gulp-cli
RUN npm install
RUN gulp

FROM nginx AS deploy

LABEL com.centurylinklabs.watchtower.enable="true"
COPY --from=build /app /usr/share/nginx/html/
