# stage1 - build react app first 
FROM ubuntu:latest as build
WORKDIR /usr/src/app
# ARG REACT_APP_API_BASE_ADRESS
COPY . ./
RUN npm ci
RUN npm build

# stage 2 - build the final image and copy the react build files
FROM nginx:1.25-alpine
ENV API host.docker.internal:8080
COPY --from=build nginx/default.conf.template /etc/nginx/templates/default.conf.template
COPY --from=build /dist /usr/share/nginx/html
EXPOSE 80
