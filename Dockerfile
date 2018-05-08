FROM nginx


RUN apt-get update \
&& apt-get install -y -q --no-install-recommends \
openssl

# create keys for https
RUN /bin/bash -c '/usr/bin/openssl req -x509 -out localhost.crt -keyout localhost.key -newkey rsa:2048 -nodes -sha256 -subj "/CN=localhost" -extensions EXT -config <( printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")'

COPY index.html /usr/share/nginx/html/index.html
COPY configf /etc/nginx/nginx.conf
EXPOSE 80
EXPOSE 443
CMD ["nginx","-g","daemon off;"]
