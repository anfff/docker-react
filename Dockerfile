# BUILD PHASE
  # BASE IMAGE - name build stage
  FROM node:alpine as builder

  # SET UP WORKING DIRECTORY IN CONTAINER
  WORKDIR '/app'

  # COPY json package
  COPY package*.json ./

  # INSTALL DEPENDENCIES
  RUN npm install

  # COPY EVERYTHING ELSE
  COPY . .

  # THIS CREATE A BUILD FOLDER - path to that folder will be /app/build (this is what we care about)
  RUN npm run build

# RUN PHASE
  # BASE IMAGE - name build stage
  FROM nginx

  # EXPOSE PORT
  EXPOSE 80

  # COPY RESULT OF BUILD PHASE called builder from folder /app/build/ to specified folder from nginx documentation
  COPY --from=builder /app/build /usr/share/nginx/html

  # DEFAULT COMMAND OF NGINX IS GOING TO START UP NGINX FOR US, WE DON'T NEED TO SPECIFY ANTYHING
