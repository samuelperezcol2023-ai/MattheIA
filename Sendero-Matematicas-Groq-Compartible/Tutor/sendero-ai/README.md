# Sendero — tutor adaptativo de Matemáticas + Groq

Esta versión está preparada para compartir de forma segura: la clave de Groq **nunca está en el HTML**. El navegador habla con `/api/tutor` y `/api/ask`, y el backend Node/Express es quien llama a Groq.

## Qué cambia

- La aplicación queda dedicada exclusivamente a **Matemáticas**.
- Se eliminó del inicio la selección de «área a reforzar».
- Al comenzar, el estudiante hace un **diagnóstico de 10 preguntas**, ordenadas de lo más básico a lo más avanzado.
- El resultado del diagnóstico determina el nivel inicial de 1 a 7.
- Después del diagnóstico se conservan las 3 preguntas de personalización del estilo de aprendizaje.
- El tutor adaptativo sigue trabajando en niveles 1–10.
- Groq usa `openai/gpt-oss-120b` para el tutor matemático.
- Las imágenes adjuntas se procesan con `qwen/qwen3.8-27b`, que tiene visión.
- TXT, MD, CSV y JSON se pueden adjuntar como texto.
- La clave se guarda en `.env`.
- Se agregó un límite sencillo por IP para reducir el abuso cuando el backend esté publicado.

## Importante sobre compartir

Un ZIP por sí solo **no puede compartir tu servidor de Groq**. Si envías este ZIP a otra persona, esa persona puede ejecutarlo localmente, pero necesitará su propia `GROQ_API_KEY`.

Si quieres que varias personas entren con un enlace sin instalar Node.js ni poner una llave, debes publicar este proyecto en un servidor. El proyecto ya está preparado para ello y contiene `render.yaml` como configuración de despliegue.

Una vez publicado, la estructura será:

Usuario → Sendero web → backend `/api/tutor` → Groq

La clave de Groq permanece en las variables de entorno del servidor.

## Ejecutarlo en tu computador

Requisitos:
- Node.js 20 o superior.
- Una clave de Groq.

1. Copia `.env.example` a `.env`.
2. Abre `.env` y coloca:

```env
GROQ_API_KEY=gsk_TU_CLAVE
```

3. Instala:

```bash
npm install
```

4. Inicia:

```bash
npm start
```

5. Abre:

```text
http://localhost:3000/tutor-app.html
```

También puedes ejecutar `iniciar-sendero.bat` en Windows.

Comprueba el backend en:

```text
http://localhost:3000/api/health
```

Debe devolver `ok: true` y `aiConfigured: true`.

## Publicarlo para compartir por enlace

La opción recomendada es desplegar el proyecto como un servicio web Node.

El archivo `render.yaml` deja preparada la configuración. En el panel del proveedor debes crear la variable secreta:

```text
GROQ_API_KEY
```

No la escribas en `tutor-app.html`, `server.mjs` ni en un archivo que vayas a subir públicamente.

Después del despliegue, abre la URL pública que te entregue el proveedor. Como frontend y backend se sirven desde el mismo proyecto, el navegador utilizará automáticamente `/api/tutor` y `/api/ask`.

## Archivos adjuntos

Para mantener compatibilidad con los modelos actuales de Groq, esta versión acepta:
- `.txt`
- `.md`
- `.csv`
- `.json`
- `.png`
- `.jpg`
- `.jpeg`
- `.webp`

Las imágenes se envían al modelo con visión. Los archivos de texto se incluyen como contenido para el tutor.

## Seguridad

- `.env` está incluido en `.gitignore`.
- Nunca publiques tu `GROQ_API_KEY`.
- El backend limita el tamaño de los archivos a 10 MB y a 3 archivos por solicitud.
- Se incluye un rate limit básico de 30 solicitudes por minuto por IP.
- Para una aplicación pública grande conviene añadir autenticación, HTTPS, rate limiting persistente y almacenamiento de usuarios.

## Modelos

El tutor usa por defecto:

```text
openai/gpt-oss-120b
```

y las imágenes:

```text
qwen/qwen3.8-27b
```

Puedes cambiarlos desde `.env` sin modificar el código.
