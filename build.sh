#!/bin/bash

set -e

python3 -m pip install grpcio
python3 -m pip install grpcio-tools

GEN_PATH="."
GO_LIB_PATH=$(go env GOPATH)/src
GOPATH=$(go env GOPATH)

protoc \
        -I proto \
        -I $GO_LIB_PATH/include \
        --go_out=$GEN_PATH      --go_opt=paths=source_relative \
        --go-grpc_out=$GEN_PATH --go-grpc_opt=paths=source_relative \
        --grpc-gateway_out=logtostderr=true,paths=source_relative:$GEN_PATH \
        --openapiv2_out=logtostderr=true:$GEN_PATH \
        proto/template.proto


python3 -m grpc_tools.protoc \
        -I proto \
        -I $GOPATH/src/include \
        --python_out=$GEN_PATH/template \
        $GOPATH/src/include/protoc-gen-openapiv2/options/annotations.proto

python3 -m grpc_tools.protoc \
        -I proto \
        -I $GOPATH/src/include \
        --python_out=$GEN_PATH/template \
        $GOPATH/src/include/protoc-gen-openapiv2/options/openapiv2.proto

python3 -m grpc_tools.protoc \
        -I proto \
        -I $GOPATH/src/include \
        --python_out=$GEN_PATH/template \
        --grpc_python_out=$GEN_PATH/template \
        proto/template.proto


echo "mod tidy"
go mod tidy

echo "update"
go get -u ./...
