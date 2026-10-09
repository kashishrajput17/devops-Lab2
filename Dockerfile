# 1. Base image: small Debian-based Python runtime
FROM python:3.12-slim

# 2. Runtime settings (metadata layers)
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    APP_ENV=production

# 3. Working directory inside the image
WORKDIR /app

# 4. Install dependencies first: this layer is cached until requirements.txt changes
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copy the application code (changes often, so it comes last)
COPY app.py .

# 6. Run as a non-root user for security
RUN useradd --create-home appuser
USER appuser

# 7. Document the port and define the start command
EXPOSE 5000
HEALTHCHECK --interval=30s --timeout=3s \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/health')"
CMD ["python", "app.py"]
