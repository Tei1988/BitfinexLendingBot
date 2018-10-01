FROM golang:alpine3.8 AS build
ARG REPO

RUN apk --update add git binutils
RUN echo "$REPO"
RUN go get -v github.com/golang/dep && \
    go install -v github.com/golang/dep/cmd/dep
ADD . /go/src/$REPO
RUN cd /go/src/$REPO && \
    dep ensure && \
    go build && \
    strip BitfinexLendingBot

FROM alpine:3.8
ARG REPO

WORKDIR /opt/app

COPY --from=build /go/src/$REPO/BitfinexLendingBot .
CMD /opt/app/BitfinexLendingBot --updatelends --dry-run --daemon
