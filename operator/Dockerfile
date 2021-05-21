# Build the go binary
FROM golang:latest as build
WORKDIR /app
COPY ./* .
RUN go build

# Copy binary into production image, ideally a
# lighter image
FROM ubuntu:latest
COPY --from=build /app/personal ./app
CMD ["./app"]
