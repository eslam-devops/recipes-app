FROM python:3.9-slim
WORKDIR /app
COPY  requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

# Use an official Python runtime as a parent image
# FROM python:3.9-slim
# docker build -t recipes_app .
#docker run -d -p 8000:8000 recipes_app
# Set the working directory in the container
# WORKDIR /app
# Copy the current directory contents into the container at /app
# COPY . .
# Install any needed packages specified in requirements.txt
# RUN pip install --no-cache-dir -r requirements.txt
# Make port 8000 available to the world outside this container
# EXPOSE 8000
# Define environment variable
# ENV NAME World
# Run app.py when the container launches
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
# docker build -t recipes_app .
#docker run -d --name rec_app -p 8000:8000 recipes_app
#docker commit rec_app recipes_app:latest
#docker tag  recipes_app:latest your_dockerhub_username/recipes_app:latest
#docker push your_dockerhub_username/recipes_app:latest
# docker login

