FROM alpine:latest

# Make sure we have an image with fundamental utilities in it
# base64 is already in alpine.
# perl-utils provides shasum
# We get perl with perl-utils
RUN apk update && apk add --no-cache  bash jq perl-utils
CMD [ "bash" ]
