FROM node:21.6.1-bullseye as builder
CMD npm config set registry https://registry.npmmirror.com
WORKDIR /app
ADD . /app
RUN --mount=type=cache,target=/app/node_modules,sharing=locked \
    npm install ;\
    npm run build


FROM nginx:stable-bullseye
ADD ./.deploy/blog.conf /etc/nginx/nginx.conf
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
