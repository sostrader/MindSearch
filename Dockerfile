# Use Python 3.11.9 as the base image
FROM python:3.11.9-slim

# Set the working directory
WORKDIR /root


# Install Git
RUN apt-get update && apt-get install -y git && apt-get clean && rm -rf /var/lib/apt/lists/*


RUN pip install --no-cache-dir \
    duckduckgo_search==5.3.1b1 \
    einops \
    fastapi \
    janus \
    pyvis \
    sse-starlette \
    termcolor \
    uvicorn \
    griffe==0.48.0 \
    python-dotenv \
    lmdeploy

RUN pip install --no-cache-dir git+https://github.com/InternLM/lagent.git

COPY mindsearch /root/mindsearch

EXPOSE 80

# 启动 FastAPI 服务
CMD ["python", "-m", "mindsearch.app","--lang", "en", "--host", "0.0.0.0", "--port", "80"]
# Copy the mindsearch folder to the /root directory of the container
