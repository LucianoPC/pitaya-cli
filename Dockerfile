FROM golang:1.14.2

WORKDIR /go/src/github.com/lucianopc/pitaya-cli

COPY . .

RUN mkdir /app
RUN go build -o /app/pitaya-cli ./...

CMD ["go", "run", "./..."]
