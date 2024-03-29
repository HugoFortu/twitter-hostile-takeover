# Twitter hostile takeover - Development guidelines
You need to have docker and docker-compose installed, please check that you have one version installed:

```bash
docker -v
```

```bash
docker-compose -v
```
If you haven't docker or docker-compose, you can install Docker Desktop if it possible:
https://docs.docker.com/desktop/install/mac-install


## **Initial setup**
You need to fork this repository, and after, run the following commands on a local folder of your choice:

Obviously, the following command is for my repo, but you need to clone yours after fork it.
```bash
git clone git@github.com:HugoFortu/twitter-hostile-takeover.git
```
```bash
cd twitter-hostile-takeover
```

## Environment variables

Create a new file .env at the root of the project, and add theses environment variables:


| Name                           | Value                            | Description               |
|--------------------------------|----------------------------------|------------------  |
| POSTGRES_USER                  | pg                               | db user               |
| POSTGRES_PASSWORD              | pg                               | db password           |
| NUXT_PUBLIC_BASE_API_URL       | http://0.0.0.0:8080              | Rails app api url        |
| DEVISE_JWT_SECRET_KEY          | jd69hD6hydi46suDgi8              | the key to decrypt user token |

You can also generate your own JWT key and replace it.

## **Start the stack**

```bash
docker-compose up
```

After the containers are built, open a new terminal window and create the DB

```bash
docker-compose exec backend rails db:create db:migrate db:seed
```

You can now go to http://localhost:3000 and create your account.

You can launch Rspec test with 

```bash
docker-compose exec backend bundle exec rspec
```

You can close docker-compose up with Ctrl + C

## **Warnings**

Sometimes, when you run 'docker-compose up', the frontend container crash with this error :
[nitro] [uncaughtException] Error: listen EADDRINUSE: address already in use /tmp/nitro/worker-29-1.sock

I didn't have the time to fix it totally, but you can use next command to solve it temporarily

```bash
docker-compose up --force-recreate
```

Regarding Active Storage, if you want use this project in production, you need to use a service like S3 or Cloudinary.
Here, images are stored in the folder 'storage', in backend folder.


