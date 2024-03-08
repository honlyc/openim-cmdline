# openim-cmdline
Command line tool for OpenIM

## Installation

### Install openim-cmdline

```shell
go install github.com/honlyc/openim-cmdline/openim
```

### Dependencies

#### install protoc-gen-go-grpc
```shell
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc
```

#### install protoc-gen-go-http
```shell
go install github.com/honlyc/openim-cmdline/protoc-gen-go-http
```

#### install protoc

docs: https://grpc.io/docs/protoc-installation/

Mac:
```shell
brew install protobuf
```

# Quick Start

## Generation Client

auth.proto
```protobuf
syntax = "proto3";
package OpenIMCmdLine.auth;
option go_package = "github.com/honlyc/openim-cmdline/protocol/auth";

import "google/api/annotations.proto";
import "options/openim.proto";

message userTokenReq {
  string secret = 1;
  int32  platformID = 2;
  string userID = 3;
}
message userTokenResp {
  string token = 2;
  int64  expireTimeSeconds = 3;
}

message getUserTokenReq{
  int32  platformID = 1;
  string userID = 2;
}

message getUserTokenResp{
  string token = 1;
  int64  expireTimeSeconds = 2;
}

service Auth {
  // 路由内校验 token
  option (openim.server).token = true;
  
  //生成token
  rpc userToken(userTokenReq) returns(userTokenResp){
    option (google.api.http) = {
      post: "/auth/user_token",
      body: "*"
    };
  };
  // 管理员获取用户 token
  rpc getUserToken(getUserTokenReq)returns(getUserTokenResp){
    option (google.api.http) = {
      post: "/auth/get_user_token",
      body: "*"
    };
    // path 内校验 Token
    option (openim.method).token = true;
  };
}
```

```shell
openim proto client auth/auth.proto -- --proto_path=/usr/local/include/
```

## Use HTTP and GRPC

```go
r := gin.New()
// get Token Parser by Gin HandlerFunc
ParseToken := GinParseToken(config)
authApi := NewAuthApi(*authRpc)
auth.RegisterAuthHTTPServer(r, ParseToken, &authApi)
```