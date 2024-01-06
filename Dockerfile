# dockerfile.txt


FROM python:3.9.4

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container at /app
COPY requirements.txt /app/

#Setting and activating virtual Environment for python packages installation

ENV VIRTUAL_ENV /env
ENV PATH /env/bin:$PATH



# Install any needed packages specified in requirements.txt

RUN pip3 install --no-cache-dir -r requirements.txt
RUN which python

# Copy the rest of your application code into the container
COPY . /app/

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]





