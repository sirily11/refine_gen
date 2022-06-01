# Refine Gen

Refine gen is a generator for `Django Rest framework` and `Refine admin framework`. It will generate api UI pages based on the metadata fetched from Django rest API endpoint.

To use this, first download the zip files from [GitHub Release](https://github.com/sirily11/refine_gen/releases). Create a config.yaml like this

```yaml
baseURL: http://localhost:8000/api
outFolder: /your/folder
viewTypes:
  - create
  - list
  - edit
  - detail
excludePaths:
  - user
```