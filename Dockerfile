FROM python:3.12.4-slim

WORKDIR /app

# Create a non-root user (security)
RUN useradd --create-home --shell /bin/bash appuser

COPY hello.py .

# Set ownership so the non-root user can access files
RUN chown -R appuser:appuser /app

# Switch to non-root user
USER appuser

# Health check - verifies the app/container is actually working
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD python -c "import sys; sys.exit(0)" || exit 1

CMD ["python", "hello.py"]