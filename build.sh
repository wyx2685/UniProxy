export CGO_ENABLED=0
if [ "$GOOS" == "windows" ]
then
  suf=".exe"
fi
wget https://github.com/SagerNet/sing-geosite/releases/latest/download/geosite.db -O geo/geosite.dat
wget https://github.com/SagerNet/sing-geoip/releases/latest/download/geoip.db -O geo/geoip.dat

uni="uniproxy"
cd cmd/$uni || exit
go build -v -o ../../uniproxy$suf -ldflags '-s -w' -gcflags="all=-trimpath=${PWD}" -asmflags="all=-trimpath=${PWD}" -tags "with_reality_server with_quic with_grpc with_utls with_wireguard"
cd ../reset || exit
go build -v -o ../../reset$suf -ldflags '-s -w' -gcflags="all=-trimpath=${PWD}" -asmflags="all=-trimpath=${PWD}"