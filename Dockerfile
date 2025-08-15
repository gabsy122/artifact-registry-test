# Step 1: Build the Go binary
FROM golang:1.24.3 as builder

WORKDIR /app
COPY . ./
RUN go mod init hello-world
RUN go build -o /hello-world .

# Step 2: Create the final image
FROM gcr.io/distroless/base-debian11

WORKDIR /
COPY --from=builder /hello-world /hello-world

ENV PORT 8080
USER nonroot:nonroot

CMD ["/hello-world"]

