# Running AppGini Apps On Docker

This repository is a guide template for running AppGini apps on Docker. 
The included `docker-compose.yml` file launches your app in an Apache container that runs PHP. 
The database is launched in a separate MySQL container. A special LetsEncrypt container is 
used to automatically obtain and renew SSL certificates for your app.

[AppGini](https://bigprof.com/appgini/) is a web application generator that
allows you to build web-based database applications rapidly. This guide
assumes that you have already built your AppGini app and have the source code
ready to be deployed.

[Docker](https://www.docker.com/) is a platform that allows developers to package their 
software applications and their dependencies into small, lightweight units called containers. 
These containers are isolated and contain everything needed to run the application, making 
it easy to deploy and run the same application consistently across different environments. 

## Prerequisites

### 1. A linux server, with root access

You need to have a linux server with root access. You can use a VPS (Virtual Private Server)
from a hosting provider, or a dedicated server, or a server in your office. To run Docker smoothly,
your server should have at least 2GB of RAM.

You must also be able to connect to your server using SSH. If you are using Windows, you can use
[Putty](https://www.putty.org/) to connect to your server.

### 2. Docker Engine

You need to have [Docker Engine](https://docs.docker.com/engine/install/) installed on your server
(including Docker Compose plugin). To check if Docker is installed, run the following command 
from a terminal on your server:

```bash
docker --version
```

If Docker is installed, you should see something like this:

```bash
Docker version 24.0.7, build afdd53b
```

Also, check that Docker Compose is installed by running the following command:

```bash
docker-compose --version
```

If Docker Compose is installed, you should see something like this:

```bash
Docker Compose version v2.20.0
```

> If Docker is not installed, please follow the instructions in the
> [Docker documentation](https://docs.docker.com/engine/install/) to install it.

### 3. A domain name

You need to have a domain name (for example, `myapp.com`) that points to your server's IP address.
You might also use a subdomain (for example, `myapp.mydomain.com`).

## Clone this repository

Clone this repository to your server. You can do this by running the following command
from a terminal on your server:

```bash
git clone https://github.com/bigprof-software/appgini-on-docker.git \
   ~/appgini-on-docker && \
cd ~/appgini-on-docker && \
cp example.env .env
```

The above command will clone this repository to the `appgini-on-docker` directory in your
home directory, and will copy the `example.env` file to `.env` in the same directory.

## Prepare your AppGini app for deployment

If you are running Docker on the same machine where you have AppGini installed,
you should copy your AppGini app files to the `app` directory in this repository.

If you are running Docker on a different machine, you should upload your AppGini
app files to the `app` directory in this repository. You can use an FTP client to upload
the files (for example, [FileZilla](https://filezilla-project.org/)). You could alternatively
use an SCP client (for example, [WinSCP](https://winscp.net/)) if FTP is not available.

#### But I recommend using the AppGini [application uploader](https://bigprof.com/appgini/help/application-uploader)

The application uploader ensures that all files are uploaded correctly, with the correct
permissions, in the correct directories. Later on, when you make changes to your app and
want to deploy the changes, you can use the application uploader again to upload only the
changed files.

To use the application uploader, you need to upload a single file to the `app` directory
in this repository. This file is called `file-uploader.php`. You can find it in the
directory where your AppGini app is generated. You'll need an FTP client or a SCP client
to upload this file to the `app` directory in this repository. But this will be needed
only once, when you first deploy your app. Later on, the application uploader will handle
all uploads for you.

> **Note:** Make sure the files copied/uploaded to the `app` directory don't include
> the `config.php` or the `setup.md5` files. Both files might exist if you are testing your app 
> locally on your machine. We don't want to include them on the server as their locally-configured
> settings would cause errors on the server. By using the application uploader, you can ensure that
> these files are not uploaded.

## Configure your docker environment

Open the `.env` file in the `appgini-on-docker` directory in your home directory, and
edit the following variables:

* `TOP_DOMAIN` - set this to your domain/subdomain name (for example, `myapp.com` or `myapp.mydomain.com`)
* `MYSQL_ROOT_PASSWORD` - set this to a strong password for the MySQL root user. You can generate a strong password by running the following command from a terminal on your server:

  ```bash
  openssl rand -base64 32 | tr -d /=+
  ```
* `LETSENCRYPT_EMAIL` - set this to your email address. This is used by Let's Encrypt to send you expiry notifications for your SSL certificates.

## Launch your app via Docker Compose

Run the following command from a terminal on your server:

```bash
docker-compose up -d
```

This will launch your app in the background. You can now access your app by visiting your domain/subdomain in your browser.

If you've uploaded all your app files (via FTP or SCP), you should see your app's setup page. Follow the instructions to complete the setup.

If you've uploaded only the `file-uploader.php` file, you should see a blank page. You should use AppGini to upload your app as explained
in the [application uploader documentation](https://bigprof.com/appgini/help/application-uploader).

After you've uploaded your app, you should see your app's setup page. Follow the instructions to complete the setup.

> Hint: Your MySQL server is `db`, your MySQL username is `root`, and your MySQL password is the one you set in the `.env` file.

