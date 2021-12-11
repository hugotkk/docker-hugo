docker compose for hosting Hugo

tt will do `hugo server` on customized Hugo folder

```
cp .env.sample .env
```

Update the blog dir

```
vi .env
```

```
blog_dir=<hugo_blog_directory>
```

Start the service
```
docker-compose up -d
```

Browse `http://localhost:1313/`
