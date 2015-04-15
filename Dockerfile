FROM python:2-onbuild
MAINTAINER James Swanick "swanijam@gmail.com"

RUN apt-get update -qq
RUN apt-get install unzip -y

# Initialize a vanilla Harvest project
RUN harvest init --no-input --no-env project 2>&1 > /dev/null

# Work inside of the generated "project" directory containing the Harvest project.
WORKDIR project/
# Add settings and entrypoint script.
ADD local_settings.py ./project/conf/
ADD start ./

# Default names of the input files.
ENV METADATA_FILE metadata.csv
ENV DATA_FILE data.csv

# Run the entrypoint script which sets up the instance with the REDCap data.
ENTRYPOINT ["/bin/bash", "./start"]

CMD ["runserver", "0.0.0.0:8000"]

EXPOSE 8000
