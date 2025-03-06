# Menggunakan node versi LTS (long-term support)
# dengan basis distro alpine supaya ringan
# AS base berarti image ini diberi nama base untuk basis container image
FROM node:lts-alpine AS base
# Membuat semua perintah yang akan dijalankan selanjutnya berada di direktori /src
WORKDIR /src
# Menyalin semua file dengan pola package*.json dari host ke container image
COPY package*.json .

# Menambahkan bash menggunakan package manager apk untuk alpine linux
RUN apk add --no-cache bash
# Menambahkan script untuk menunggu yang nantinya dijadikan sebagai command untuk menunggu jalannya container
RUN wget -O /bin/wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh
# Memodifikasi file wait-for-it.sh agar bisa dijalankan (executable)
RUN chmod +x /bin/wait-for-it.sh

# Menggunakan image "base" dan diberi nama production
FROM base AS production
# Menentukan variabel NODE_ENV dengan nilai production di environment container image
ENV NODE_ENV=production
# Menginstall semua dependensi yang dibutuhkan aplikasi dengan npm
RUN npm ci
# Menyalin semua file berekstensi .js dari host ke container image
COPY ./*.js .
# Menjalankan perintah "node index.js" ketika container dijalankan
CMD ["node", "index.js"]