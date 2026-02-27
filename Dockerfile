# ---------- Build Stage ----------
FROM node:23.7 AS build

WORKDIR /app


COPY package*.json ./
RUN npm ci


COPY . .

# Build Angular app
RUN npm run build


# ---------- Runtime Stage ----------
FROM nginx:alpine

COPY --from=build /app/dist/hello-world/browser /usr/share/nginx/html

EXPOSE 80
