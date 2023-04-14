# Stage 1: Build the application
FROM python:3.9-slim-buster AS build
WORKDIR /app
COPY requirements.txt .
RUN pip install --user -r requirements.txt
COPY . .
RUN python setup.py install

# Stage 2: Create the runtime image
FROM python:3.9-slim-buster
WORKDIR /app
COPY --from=build /root/.local /root/.local
COPY . .
ENV PATH=/root/.local/bin:$PATH
CMD ["python", "app.py"]