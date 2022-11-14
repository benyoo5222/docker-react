# Multi build steps
# Build phase - Node -> Npm install -> Npm build
FROM node:16-alpine as builder

# Working directory
WORKDIR /app

# Copy package json
COPY ./package.json ./
# Install dependencies
RUN npm install 

# We need to copy over rest of files and then run another command
COPY ./  ./
RUN npm run build

# Phase 2: Get the build folder and then create a new image of just that build folder and then also have Nginx folders
FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html