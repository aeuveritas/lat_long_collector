# lat_long_collector

Collect latitude and longitude

## Getting Started

1. Get Kakao Map API from `https://apis.map.kakao.com`
2. Make .env from .env.template
```env
KAKAO_API_KEY=<KAKAO-API-KEY>
BLOCK_INTERVAL_SECONDS=<BLOCK-INTERVAL-FOR-REST-API-IN-SECONDS>
```
3. Build
```sh
# Enable Windows developer mode
$ start ms-settings:developers

$ flutter pub get

$ flutter pub run build_runner build --delete-conflicting-outputs

# For windows
$ flutter pub run msix:create
```