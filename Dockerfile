FROM golang:1.16
WORKDIR /app
COPY go.mod .
COPY go.sum .
RUN go mod download

ARG CGO_ENABLED=0
ARG GOOS=linux
ARG GOARCH=amd64

COPY main.go .
RUN go build -o /app/bin/main
RUN go install main.go

EXPOSE 8080
RUN chmod a+x /app/bin/main

# Run the executable
CMD ["/app/bin/main"]

# docker run -e DEBUG=true -p 8080:8080 simpleserver:latest