# Stage 1: Build the Angular app
FROM node:18.20.4 AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

RUN npm install -g @angular/cli

COPY . .

RUN ng build 

# Stage 2: Run the Angular app with a lightweight web server (nginx)
FROM nginx:alpine

COPY --from=build /app/dist/ng-beginner /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
