FROM nginx:alpine

# Copy static website
COPY index.html /usr/share/nginx/html/index.html

# Nginx config for SPA
RUN echo 'server { \
    listen 8080; \
    root /usr/share/nginx/html; \
    index index.html; \
    server_name _; \
    location / { \
        try_files $uri $uri/ /index.html; \
        add_header Access-Control-Allow-Origin "*"; \
        add_header Cache-Control "no-cache, no-store, must-revalidate"; \
    } \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=2 \
    CMD wget -qO- http://localhost:8080/ || exit 1

CMD ["nginx", "-g", "daemon off;"]