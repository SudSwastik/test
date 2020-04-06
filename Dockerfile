FROM node:alpine as builder

# Creates a Directory Inside the Image where all the Files will be Copied
WORKDIR '/app'

# Only package.json is copied to restrict node_modules from being copied to image 
COPY package.json .
RUN npm install

COPY  . .
RUN npm run build

# Copies The build directory created during npm build inside the working 
# directory app and copies to nginx static file serving directoty 
FROM nginx
COPY --from=builder /app/build  /usr/share/nginx/html
