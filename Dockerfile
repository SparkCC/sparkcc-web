FROM node:8 AS build

ENV GIT_REPO https://github.com/SparkCC/sparkcc-web.git
ENV GIT_BRANCH master
RUN mkdir -p /app
WORKDIR /app
RUN git clone -b $GIT_BRANCH $GIT_REPO /app 
RUN npm install --global gulp-cli
RUN npm install
RUN gulp

FROM nginx AS deploy

LABEL com.centurylinklabs.watchtower.enable="true"
COPY --from=build /app /usr/share/nginx/html/
