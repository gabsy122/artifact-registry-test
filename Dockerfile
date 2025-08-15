# Correct capitalization for FROM
FROM golang:1.24.3 AS builder

WORKDIR /app

# Use correct format for ENV
ENV GO111MODULE=on

# Copy the code into the container
COPY . ./

# Initialize Go modules and build the Go app
RUN go mod init hello-world
RUN go build -o /hello-world .

# Use the distroless base image for the final stage
FROM gcr.io/distroless/base-debian11:latest

# Copy the built binary into the distroless image
COPY --from=builder /hello-world /hello-world

# Command to run the app
CMD ["/hello-world"]

