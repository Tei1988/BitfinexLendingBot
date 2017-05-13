FROM golang:latest
ADD . /go/src/BitfinexLendingBot
WORKDIR /go/src/BitfinexLendingBot
RUN go get -u github.com/eAndrius/bitfinex-go
RUN go install .
CMD /go/bin/BitfinexLendingBot --updatelends --dryrun
# CMD /go/bin/BitfinexLendingBot --updatelends --daemon --dryrun
