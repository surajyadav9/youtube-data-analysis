# Note - all the data files JSON and CSV are store in the <project>/data/ folder

# Upload JSON raw statistics data to S3 bucket using AWS CLI
aws s3 cp . s3://youtubeanalysis-raw-useast1-315380538310-dev/youtube-data/raw_statistics_reference_data/ --recursive --exclude "*" --include "*.json"

# Upload CSV raw data to S3 bucket using AWS CLI :: Following Hive-style pattern
aws s3 cp CAvideos.csv s3://youtubeanalysis-raw-useast1-315380538310-dev/youtube-data/raw_data/region=ca/
aws s3 cp DEvideos.csv s3://youtubeanalysis-raw-useast1-315380538310-dev/youtube-data/raw_data/region=de/
aws s3 cp FRvideos.csv s3://youtubeanalysis-raw-useast1-315380538310-dev/youtube-data/raw_data/region=fr/
aws s3 cp GBvideos.csv s3://youtubeanalysis-raw-useast1-315380538310-dev/youtube-data/raw_data/region=gb/
aws s3 cp INvideos.csv s3://youtubeanalysis-raw-useast1-315380538310-dev/youtube-data/raw_data/region=in/
aws s3 cp JPvideos.csv s3://youtubeanalysis-raw-useast1-315380538310-dev/youtube-data/raw_data/region=jp/
aws s3 cp KRvideos.csv s3://youtubeanalysis-raw-useast1-315380538310-dev/youtube-data/raw_data/region=kr/
aws s3 cp MXvideos.csv s3://youtubeanalysis-raw-useast1-315380538310-dev/youtube-data/raw_data/region=mx/
aws s3 cp RUvideos.csv s3://youtubeanalysis-raw-useast1-315380538310-dev/youtube-data/raw_data/region=ru/
aws s3 cp USvideos.csv s3://youtubeanalysis-raw-useast1-315380538310-dev/youtube-data/raw_data/region=us/
