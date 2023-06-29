version: '3'
services:
  uploadscanner:
    image: uploadscanner:latest
    ports:
      - '5000:5000'
    environment:
      - SECRET_KEY=CookieSaltValue
      - S3_ACCESS_KEY_ID=Xh'your_s3_AKID'
      - S3_SECRET_ACCESS_KEY='your_s3_secret_key'
      - S3_ENDPOINT_URL='https://your-s3-endpoint.com'
      - S3_BUCKET_NAME=testapp
      - SCAN_API_BASE_URL='http://antimalware_microservice:8080'
      - SCAN_API_USERNAME=apiUser
      - SCAN_API_PASSWORD=apiPassword
      - S3_REGION=Virginia
    networks:
      - testapp

  antimalware_microservice:
    image: registry1.dso.mil/ironbank/skyhighsecurity/gam/gamapi/gamapi:20.19-3
    environment:
      - AIRGAPPED=true
      - APIUSERNAME=apiUser
      - APIUSERPASSWORD=apiPassword
    ports:
      - '8080'
    volumes:
      - '/path/to/updates:/app/updates' #You need to get your updates.zip from Skyigh sales as this includes your license information
    restart: unless-stopped
    networks:
      - testapp

networks:
  testapp:
