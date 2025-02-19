docker run -it --rm -p 8888:8888 -v $(pwd):/app -v $(pwd)/.jupyter:/root/.jupyter -v jupyter-data:/root/.local langchain-docker-app
