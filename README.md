# openim-cmdline
Command line tool for OpenIM

## install protoc-gen-go-grpc
```shell
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc
```

## install protoc

docs: https://grpc.io/docs/protoc-installation/

Mac:
```shell
brew install protobuf
```

# Use

## install

```shell
go install github.com/honlyc/openim-cmdline/openim
```

## generate

```shell
openim proto client auth/auth.proto -- --proto_path=/usr/local/include/
```