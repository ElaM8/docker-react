FROM node:16-alpine as builder

WORKDIR '/app'

COPY package.json .

RUN npm install

COPY . .

RUN npm run build

# multistep process - the build files/folder feeds into the second from. We're not pulling over anything from the alpine image or the npm i


FROM nginx 

EXPOSE 80
# is this required? I'm already exposing a port with docker compose

COPY --from=builder /app/build /usr/share/nginx/html

# starts automatically, so there's no run command required. 
# starts automatically because the default command for the nginx image is start
