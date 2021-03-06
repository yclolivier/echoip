# Build
FROM golang:1.11-stretch AS build
WORKDIR /go/src/github.com/mpolden/echoip
COPY . .
ENV GO111MODULE=on CGO_ENABLED=0
RUN go install ./...

# Run
FROM scratch
EXPOSE 8080
COPY --from=build \
     /go/bin/echoip \
     /go/src/github.com/mpolden/echoip/index.html \
     /opt/echoip/
WORKDIR /opt/echoip
ENTRYPOINT ["/opt/echoip/echoip"]
