FROM node:alpine AS builder

# Config node to run as root
RUN npm -g config set user root

# Install ImageMagick, SCSS compiler & minifier
RUN apk --update add imagemagick
RUN npm install --global --quiet node-sass uglifycss

# Copy static files
COPY src/static .

# ImageMagick convert the logo into some favicons
RUN convert ./assets/favicon/logo.svg -resize 16x16 ./assets/favicon/16x16.png
RUN convert ./assets/favicon/logo.svg -resize 32x32 ./assets/favicon/32x32.png
RUN convert ./assets/favicon/logo.svg -resize 96x96 ./assets/favicon/96x96.png

# Compile and minify scss
RUN node-sass css/styles.scss css/styles.css
RUN uglifycss css/styles.css > css/styles.min.css

# EXECUTOR does the server-y stuff
FROM python:3.7-alpine

# Copy the source code into the current dir
COPY requirements-prod.txt .

# Install from the prod-requirements.txt and delete it from the image
RUN pip install --no-cache-dir -r requirements-prod.txt && rm requirements-prod.txt

# Copy the srouce code over
COPY src .

# Copy the modified staticfiles from the builder stage
COPY --from=builder assets/favicon/16x16.png static/assets/favicon/16x16.png
COPY --from=builder assets/favicon/32x32.png static/assets/favicon/32x32.png
COPY --from=builder assets/favicon/96x96.png static/assets/favicon/96x96.png
COPY --from=builder css/styles.min.css static/css/styles.min.css

# Expose a port for the webserver
EXPOSE 9001

CMD ["gunicorn", "-w 4", "-b 0.0.0.0:9001", "app:app"]