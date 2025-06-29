FROM docker:20.10.24-cli

# install git 
RUN apk add --no-cache git

# Copy the builder script into the container
COPY builder.sh /builder.sh 

# make it executable
RUN chmod +x /builder.sh

# set the entryboint ot the script 

ENTRYPOINT ["/builder.sh"]
