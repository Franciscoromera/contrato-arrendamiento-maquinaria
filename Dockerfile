FROM nginx:1.27-alpine

LABEL org.opencontainers.image.title="Contrato de arrendamiento de maquinaria de obra publica"
LABEL org.opencontainers.image.description="Modelo estandar de contrato de arrendamiento de maquinaria y vehiculos de obra publica sin operador y sin combustible. Web estatica con PDF y Word descargables."
LABEL org.opencontainers.image.version="1.0"
LABEL org.opencontainers.image.licenses="Proprietary"

# Configuracion del servidor web
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Contenido del sitio (HTML, PDF y DOCX)
RUN rm -rf /usr/share/nginx/html/*
COPY site/ /usr/share/nginx/html/
RUN chmod -R a+rX /usr/share/nginx/html

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -q -O /dev/null http://127.0.0.1/healthz || exit 1

CMD ["nginx", "-g", "daemon off;"]