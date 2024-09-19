export CGO_ENABLED=0
mkdir -p output/geo
wget https://github.com/SagerNet/sing-geosite/releases/latest/download/geosite.db -O output/geo/geosite.db
wget https://github.com/SagerNet/sing-geoip/releases/latest/download/geoip.db -O output/geo/geoip.db


cd cmd/uniproxy || exit
GOOS=darwin GOARCH=amd64 go build -v -o ../../output/darwin-x64/uniproxy -ldflags '-s -w' -gcflags="all=-trimpath=${PWD}" -asmflags="all=-trimpath=${PWD}" -tags "with_reality_server with_quic with_grpc with_utls with_wireguard"
GOOS=darwin GOARCH=arm64 go build -v -o ../../output/darwin-arm64/uniproxy -ldflags '-s -w' -gcflags="all=-trimpath=${PWD}" -asmflags="all=-trimpath=${PWD}" -tags "with_reality_server with_quic with_grpc with_utls with_wireguard"
GOOS=windows GOARCH=386 go build -v -o ../../output/win32-x64/uniproxy.exe -ldflags '-s -w' -gcflags="all=-trimpath=${PWD}" -asmflags="all=-trimpath=${PWD}" -tags "with_reality_server with_quic with_grpc with_utls with_wireguard"


cd ../reset || exit
GOOS=darwin GOARCH=amd64 go build -v -o ../../output/darwin-x64/reset -ldflags '-s -w' -gcflags="all=-trimpath=${PWD}" -asmflags="all=-trimpath=${PWD}"
GOOS=darwin GOARCH=arm64 go build -v -o ../../output/darwin-arm64/reset -ldflags '-s -w' -gcflags="all=-trimpath=${PWD}" -asmflags="all=-trimpath=${PWD}"
GOOS=windows GOARCH=386 go build -v -o ../../output/win32-x64/reset.exe -ldflags '-s -w' -gcflags="all=-trimpath=${PWD}" -asmflags="all=-trimpath=${PWD}"

cd ../unielevate || exit
GOOS=windows GOARCH=386 go build -v -o ../../output/win32-x64/elevate.exe -ldflags '-s -w' -gcflags="all=-trimpath=${PWD}" -asmflags="all=-trimpath=${PWD}"
