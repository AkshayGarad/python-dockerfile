# Python Application Dockerfile
This is an example multi-stage Dockerfile for building and running a Python application. The Dockerfile uses two stages: the first stage builds the application with its dependencies, and the second stage creates a smaller runtime image with only the necessary files to run the application.

## Prerequisites
Docker installed on your local machine.
## Usage
1. Clone this repository to your local machine:
```bash
git clone https://github.com/AkshayGarad/python-dockerfile.git
```
2. Navigate to the project directory:
```bash
cd python-dockerfile
```
3. Build the Docker image using the following command:
```bash
docker build -t myapp:latest .
```
This will build the Docker image with the tag `myapp:latest`.

4. Run the Docker container using the following command:
```bash
docker run -p 5000:5000 myapp:latest
```
This will start the Docker container and map port 5000 on the container to port 5000 on your local machine.

5. Access the application by navigating to `http://localhost:5000` in your web browser.

## Dockerfile
This repository includes a Dockerfile that uses multi-stage builds to reduce the size of the final Docker image. The Dockerfile has two stages:

## Stage 1: Build the application with its dependencies.
## Stage 2: Create a smaller runtime image with only the necessary files to run the application.
To use this Dockerfile for your own Python application, you can modify the following lines to reference your application's name and dependencies:
```bash
COPY requirements.txt .
RUN pip install --user -r requirements.txt
COPY . .
RUN python setup.py install
```
Replace `requirements.txt` with your own requirements file, and replace `python setup.py install` with the command to install your application.

## Let's break down what's happening in each stage:

## Stage 1: Build the application

- We start with a slim Python 3.9 image and set it as our build stage.
- We create a working directory `/app` and copy the `requirements.txt` file into it.
- We install the dependencies listed in `requirements.txt` using `pip`.
- We copy the rest of the application files into the working directory.
- We run `python setup.py install` to install the application.
## Stage 2: Create the runtime image

- We start with another slim Python 3.9 image.
- We create a working directory `/app`.
- We copy the `/root/.local` directory from the build stage to the working directory in the runtime stage using the `--from=build` option to reference the build stage.
- We copy the rest of the application files into the working directory.
- We set the `PATH` environment variable to include the `/root/.local/bin` directory.
- We set the default command to run the application using the `CMD` instruction.

This multi-stage Dockerfile allows us to separate the build process and the runtime environment into two separate stages, which can reduce the size of the final image by only including the files needed to run the application. In this example, we use `pip` to install the application dependencies in the build stage and then only copy the necessary files into the smaller runtime image in the second stage.