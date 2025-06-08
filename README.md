Here’s the updated **README** tailored to your Docker Hub username (`zafrans`), repository (`zafrans/cmms`), and the Docker image name (`cmms`):

---

### **Complete Guide for Docker Setup**

---

### **Step 1: Creating the Dockerfile**

1. **Open your project directory** where your PHP Slim app is located. This will typically be something like:

   ```bash
   cd /path/to/your/project
   ```

2. **Create a `Dockerfile`** inside your project directory. You can do this with any text editor or directly in the terminal. For example:

   ```bash
   touch Dockerfile
   ```

3. **Add the following content** to the `Dockerfile` (use the editor of your choice):

   ```Dockerfile
   # Use the official PHP 8.1 Alpine image as a base image
   FROM php:8.1-alpine

   # Install system dependencies and PHP extensions
   RUN apk --no-cache add \
       bash \
       git \
       libpng-dev \
       libjpeg-dev \
       libfreetype6-dev \
       && docker-php-ext-configure gd --with-freetype --with-jpeg \
       && docker-php-ext-install gd

   # Install Composer (PHP Dependency Manager)
   RUN curl -sS https://getcomposer.org/installer | php \
       && mv composer.phar /usr/local/bin/composer

   # Set the working directory to /var/www
   WORKDIR /var/www

   # Copy the composer.json and composer.lock (if available) to the container
   COPY composer.json /var/www/

   # Install PHP dependencies using Composer
   RUN composer install

   # Copy the rest of your application code to the container
   COPY . /var/www

   # Expose the port 8080
   EXPOSE 8080

   # Set the command to run the PHP built-in server
   CMD ["php", "-S", "0.0.0.0:8080", "-t", "public"]
   ```

4. **Explanation**:

   * This `Dockerfile` uses the PHP 8.1 Alpine image, installs the necessary dependencies, Composer, and copies your app files into the container.
   * It then runs the built-in PHP server on port 8080 and serves your Slim app.

---

### **Step 2: Building the Docker Image**

1. **Open the terminal** (in the same directory as the `Dockerfile`).

2. **Build the Docker image** by running:

   ```bash
   docker build -t cmms:v2 .
   ```

   * `cmms:v2` is the tag for your image.
   * The `.` at the end indicates that Docker should look for the `Dockerfile` in the current directory.

3. Docker will begin downloading the base image, installing dependencies, and setting up the environment according to the `Dockerfile`. This might take a few minutes.

4. Once it's finished, you can confirm the image was created by running:

   ```bash
   docker image ls
   ```

   You should see `cmms:v2` listed.

---

### **Step 3: Running the Docker Container**

1. Now that the image is built, **run the container** with the following command:

   ```bash
   docker run --name cmms -p 8080:8080 -d cmms:v2
   ```

   * `--name cmms`: Names the container `cmms`.
   * `-p 8080:8080`: Maps port `8080` on your machine to port `8080` in the container.
   * `-d`: Runs the container in detached mode (in the background).
   * `cmms:v2`: The image to run.

2. You can now **access your Slim application** in the browser by going to `http://localhost:8080`.

3. To confirm the container is running, you can use:

   ```bash
   docker ps
   ```

   This will show all running containers.

---

### **Step 4: Stopping the Docker Container**

1. To **stop** the running container, use:

   ```bash
   docker stop cmms
   ```

   This stops the container.

2. To **remove** the container after stopping it (optional):

   ```bash
   docker container rm cmms
   ```

---

### **Step 5: Push the Docker Image to Docker Hub**

To make it easier for your groupmates to use the image without building it from scratch, you can upload your Docker image to Docker Hub or another container registry. Here’s how:

1. **Login to Docker Hub** (if you don't have an account, create one first):

   ```bash
   docker login
   ```

2. **Tag your image for Docker Hub**:

   Tag your image with your Docker Hub username and repository name. Replace `yourusername` with `zafrans` (your Docker Hub username):

   ```bash
   docker tag cmms:v2 zafrans/cmms:v2
   ```

3. **Push the image to Docker Hub**:

   After tagging the image, you can push it to Docker Hub:

   ```bash
   docker push zafrans/cmms:v2
   ```

4. **Now, groupmates can pull the image**:

   To pull the image, your groupmates can run the following command:

   ```bash
   docker pull zafrans/cmms:v2
   ```

5. Once they have pulled the image, they can run it with the same command:

   ```bash
   docker run --name cmms -p 8080:8080 -d zafrans/cmms:v2
   ```

---

### **Step 6: Managing Docker Images, Containers, and Volumes**

#### **Stop All Running Containers:**

To stop all running containers at once, use:

```bash
docker stop $(docker ps -q)
```

#### **Remove All Containers:**

After stopping the containers, you can remove them to clean up:

```bash
docker rm $(docker ps -a -q)
```

#### **Remove Unused Volumes:**

To remove unused volumes (volumes that are no longer associated with any containers), use the following command:

```bash
docker volume prune -f
```

#### **Remove Unused Images (Optional):**

To remove all images that are not currently being used by a container, you can use:

```bash
docker image prune -a -f
```

#### **Run the Current or Existing Image (`cmms:v2`) Again:**

To run your `cmms:v2` image again, use:

```bash
docker run --name cmms -p 8080:8080 -d cmms:v2
```

---

### **Step 7: Complete Commands Recap**

Here is a complete summary of the commands you or your groupmates will need:

#### **Create and Build Docker Image**

```bash
cd /path/to/your/project          # Navigate to your project directory
touch Dockerfile                  # Create a Dockerfile (if not already created)
# Add content to Dockerfile (as shown earlier)

docker build -t cmms:v2 .      # Build the Docker image
docker image ls               # Confirm the image exists
```

#### **Run the Docker Container**

```bash
docker run --name cmms -p 8080:8080 -d cmms:v2
docker ps                         # Confirm the container is running
```

#### **Stop and Remove the Docker Container**

```bash
docker stop cmms    # Stop the container
docker container rm cmms  # Optionally, remove the container
```

#### **Push the Docker Image to Docker Hub**

```bash
docker login                      # Log in to Docker Hub (if you haven't already)
docker tag cmms:v2 zafrans/cmms:v2    # Tag the image for Docker Hub
docker push zafrans/cmms:v2  # Push the image to Docker Hub
```

#### **Pull and Run the Docker Image**

```bash
docker pull zafrans/cmms:v2  # Pull the image from Docker Hub
docker run --name cmms -p 8080:8080 -d zafrans/cmms:v2  # Run the image
```

---

### **Conclusion**

This guide covers the full process of creating a Docker image for your PHP Slim application, building it, running the container, stopping it, and how to push and pull Docker images for your groupmates to use. It also includes instructions for stopping and cleaning up all Docker containers, images, and volumes.

Feel free to ask if you need further clarification or any help!

---

This detailed README will guide you and your team through the entire Docker setup, including how to manage images, containers, and volumes. Let me know if you need anything else!
