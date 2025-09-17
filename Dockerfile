FROM golang:1.21 AS builder
WORKDIR /go/src/github.com/wakeful/selenium_grid_exporter
COPY . .
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -trimpath -ldflags="-s -w"

FROM busybox:1.27
LABEL maintainer "AJ <aj@48k.io>"
COPY --from=builder /go/src/github.com/wakeful/selenium_grid_exporter/selenium_grid_exporter .

EXPOSE 8080
ENTRYPOINT ["/selenium_grid_exporter"]
