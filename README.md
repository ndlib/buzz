# Buzz README

## Dependencies
Requires ruby v2.3.1

## Installation Notes

```console
$ bundle install
```

Generate a config/settings.yml with the following keys:
```
<rails environment>
  wowza:
    host: <host>
    port: <port>
    application: <wowza app name>
    instance: <wowza instance>
    cache_source_prefix: amazons3
    cache_source: <s3 bucket name>
```

Generate a config/secrets.yml with the following keys:
```
<rails environment>
  secret_key_base: <secret key>
```

Generate a config/database.yml with the following keys:
```
<rails environment>
  adapter: postgresql
  encoding: utf8
  reconnect: true
  pool: 5
  username: <db user>
  password: <db pass>
  host:     <db host>
  database: <db name>
  port:     <db port>
```

Create the database
```console
$ bundle exec rake db:create && bundle exec rake db:schema:load
```

## Running
```console
$ bundle exec rails server
```


An example curl command to create an identifier:
```bash
$ curl --insecure \
  -H "Content-Type: application/json" \
  -X POST \
  -d '{ "file_path": "testing/sample1.mp4", "media_type": "video" }' \
  https://localhost/v1/media_files
{
  "@context": "http://schema.org",
  "@type": "CreateAction",
  "actionStatus": "CompletedActionStatus",
  "object": {
    "@context": "http://schema.org",
    "@type": "VideoObject",
    "@id": "1e2486a7-2be6-42bc-9797-5a62b7ba188f",
    "description": "testing/sample1.mp4",
    "name": "testing/sample1.mp4",
    "thumbnailUrl": null,
    "uploadDate": "2018-11-06T15:49:47.152Z",
    "embedUrl": "https://buzz-pprd.library.nd.edu/?id=1e2486a7-2be6-42bc-9797-5a62b7ba188f",
    "contentUrl": [
      "https://wowza.library.nd.edu:443/buzz_wow/_definst_/mp4:amazons3/testlibnd-wse-honeycomb-pprd/testing/sample1.mp4/playlist.m3u8",
      "rtmps://wowza.library.nd.edu:443/buzz_wow/_definst_/mp4:amazons3/testlibnd-wse-honeycomb-pprd/testing/sample1.mp4"
    ],
    "url": "http://buzz-pprd.library.nd.edu/v1/media_files/1e2486a7-2be6-42bc-9797-5a62b7ba188f"
  }
}
```

An example curl command to get an identifier (using the example id generated above):
```bash
$ curl --insecure https://localhost/v1/media_files/1e2486a7-2be6-42bc-9797-5a62b7ba188f
{
  "@context": "http://schema.org",
  "@type": "VideoObject",
  "@id": "1e2486a7-2be6-42bc-9797-5a62b7ba188f",
  "description": "testing/sample1.mp4",
  "name": "testing/sample1.mp4",
  "thumbnailUrl": null,
  "uploadDate": "2018-11-06T15:49:47.152Z",
  "embedUrl": "https://buzz-pprd.library.nd.edu/?id=1e2486a7-2be6-42bc-9797-5a62b7ba188f",
  "contentUrl": [
    "https://wowza.library.nd.edu:443/buzz_wow/_definst_/mp4:amazons3/testlibnd-wse-honeycomb-pprd/testing/sample1.mp4/playlist.m3u8",
    "rtmps://wowza.library.nd.edu:443/buzz_wow/_definst_/mp4:amazons3/testlibnd-wse-honeycomb-pprd/testing/sample1.mp4"
  ],
  "url": "http://buzz-pprd.library.nd.edu/v1/media_files/1e2486a7-2be6-42bc-9797-5a62b7ba188f"
}
```

An example curl command to update an identifier (using the example id generated above):
```bash
$ curl --insecure \
  -H "Content-Type: application/json" \
  -X PATCH \
  -d '{ "file_path": "testing/sample1.mp4", "media_type": "video", "thumbnail_url": "mythumbnail.jpg" }' \
  https://localhost/v1/media_files/1e2486a7-2be6-42bc-9797-5a62b7ba188f
{
  "@context": "http://schema.org",
  "@type": "UpdateAction",
  "actionStatus": "CompletedActionStatus",
  "object": {
    "@context": "http://schema.org",
    "@type": "VideoObject",
    "@id": "1e2486a7-2be6-42bc-9797-5a62b7ba188f",
    "description": "testing/sample1.mp4",
    "name": "testing/sample1.mp4",
    "thumbnailUrl": "mythumbnail.jpg",
    "uploadDate": "2018-11-06T15:58:28.641Z",
    "embedUrl": "https://buzz-pprd.library.nd.edu/?id=1e2486a7-2be6-42bc-9797-5a62b7ba188f",
    "contentUrl": [
      "https://wowza.library.nd.edu:443/buzz_wow/_definst_/mp4:amazons3/testlibnd-wse-honeycomb-pprd/testing/sample1.mp4/playlist.m3u8",
      "rtmps://wowza.library.nd.edu:443/buzz_wow/_definst_/mp4:amazons3/testlibnd-wse-honeycomb-pprd/testing/sample1.mp4"
    ],
    "url": "http://buzz-pprd.library.nd.edu/v1/media_files/1e2486a7-2be6-42bc-9797-5a62b7ba188f"
  }
}
```

Render a player for an identifier (using the example id generated above):

https://localhost/?id=1e2486a7-2be6-42bc-9797-5a62b7ba188f
