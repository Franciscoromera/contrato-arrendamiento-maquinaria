# Contrato de arrendamiento de maquinaria de obra pública (web)

Aplicación web estática (imagen Docker basada en `nginx:alpine`) que publica el
**modelo estándar de contrato de arrendamiento de maquinaria y vehículos de obra pública,
sin operador y sin combustible**, con sus anexos, y que además permite descargarlo en PDF y en Word.

## Contenido publicado

| Ruta | Descripción |
|---|---|
| `/` | Contrato completo (21 estipulaciones, 4 anexos), en HTML |
| `/responsabilidades.html` | Extracto: régimen de responsabilidad por malas prácticas, abusos e impagos |
| `/contrato-arrendamiento-maquinaria-obras-publicas.pdf` | Contrato en PDF, listo para descargar |
| `/contrato-arrendamiento-maquinaria-obras-publicas-editable.docx` | Versión editable en Word |
| `/healthz` | Comprobación de estado (para el health check) |

## Requisitos

Solo Docker. No necesita base de datos, ni variables de entorno, ni volúmenes.

## Opción 1. Construir la imagen y ejecutarla

```bash
docker build -t contrato-arrendamiento-maquinaria:1.0 .
docker run -d --name contrato-arrendamiento-maquinaria \
  -p 8081:80 --restart unless-stopped contrato-arrendamiento-maquinaria:1.0
```

Comprueba que responde: `curl http://localhost:8081/`

## Opción 2. Docker Compose

```bash
docker compose up -d --build
```

## Opción 3. EasyPanel

1. **App → tu servicio (por ejemplo `contratoadaralquiler`) → Source.**
2. Elige **GitHub** e introduce la URL del repositorio (rama `main`).
3. En **Build**, deja el tipo **Dockerfile** con ruta `Dockerfile`.
4. En **Domains**, añade el dominio o subdominio que quieras y apunta al puerto **80**.
5. Pulsa **Deploy**. EasyPanel compila la imagen y arranca el contenedor.

También puedes usar **Source → Docker Image** si la imagen está publicada en un registro,
por ejemplo `ghcr.io/usuario/contrato-arrendamiento-maquinaria:latest`.

## Opción 4. Cargar la imagen ya construida (sin compilar)

Si dispones del archivo `imagen-contrato-arrendamiento-maquinaria.tar.gz`:

```bash
gunzip -c imagen-contrato-arrendamiento-maquinaria.tar.gz | docker load
docker run -d --name contrato-arrendamiento-maquinaria -p 8081:80 contrato-arrendamiento-maquinaria:1.0
```

## Actualizar el contenido

El sito vive en `site/`. Para actualizar el contrato:

```bash
# sustituye los archivos de site/ y vuelve a construir
docker compose up -d --build
```

## Aviso

Se trata de un modelo estándar de uso profesional. Se recomienda su revisión por un asesor
jurídico y la cumplimentación de las condiciones particulares (Anexo II) antes de su firma.