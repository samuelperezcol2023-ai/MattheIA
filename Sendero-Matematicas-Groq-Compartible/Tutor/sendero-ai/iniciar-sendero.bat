@echo off
setlocal
cd /d "%~dp0"

echo ========================================
echo        SENDERO - INICIO DEL BACKEND
echo ========================================

where node >nul 2>nul
if errorlevel 1 (
  echo ERROR: Node.js no esta instalado.
  echo Instala Node.js 20 o superior y vuelve a ejecutar este archivo.
  pause
  exit /b 1
)

if not exist node_modules (
  echo Instalando dependencias...
  call npm install
  if errorlevel 1 (
    echo ERROR: No se pudieron instalar las dependencias.
    pause
    exit /b 1
  )
)

if not exist .env (
  if exist .env.example copy /Y .env.example .env >nul
  echo.
  echo Se creo .env a partir de .env.example.
  echo IMPORTANTE: abre .env y coloca tu GROQ_API_KEY.
  echo.
  pause
)

echo Iniciando Sendero...
start "Sendero" cmd /k "cd /d "%~dp0" && npm start"
timeout /t 2 /nobreak >nul
start "" "http://localhost:3000/tutor-app.html"
