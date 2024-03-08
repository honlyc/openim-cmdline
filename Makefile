
install:
	@go install ./openim


options/gorm.pb.go: protoc-gen-go-http/proto/options/openim.proto
	@protoc -I=/usr/local/include -I=. --go_out=. protoc-gen-go-http/proto/options/openim.proto