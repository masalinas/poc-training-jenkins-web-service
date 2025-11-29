# Use official Nginx image
FROM nginx:alpine

# Copy our static website files into the default Nginx folder
COPY ./ /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]