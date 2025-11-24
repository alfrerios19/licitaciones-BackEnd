FROM python:3.11-slim

# Instalar dependencias del sistema para Chromium
RUN apt-get update && apt-get install -y \
    wget unzip gnupg libglib2.0-0 libnss3 libgconf-2-4 libasound2 \
    libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 libxkbcommon0 \
    libxcomposite1 libxdamage1 libxrandr2 libgbm1 libpango-1.0-0 \
    libcairo2 libxshmfence1 libxfixes3 libxext6 libx11-6 \
    && apt-get clean

# Copiar archivos
WORKDIR /app
COPY . .

# Instalar dependencias Python
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Instalar Playwright + Chromium
RUN playwright install --with-deps chromium

# Exponer el puerto
EXPOSE 8000

# Comando de ejecución
CMD ["uvicorn", "myMain:app", "--host", "0.0.0.0", "--port", "8000"]
