FROM python:3.10-rc-slim-buster

WORKDIR NexusWebMeet

COPY . .

ARG CHROMEDRIVER_VERSION

RUN apt-get update -qy
RUN apt-get update && apt-get install --quiet --assume-yes python-dev python-pip unzip wget
RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN apt update
RUN apt install -y google-chrome-stable
RUN cp requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

RUN wget --no-verbose --output-document /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip
RUN unzip -qq /tmp/chromedriver_linux64.zip -d /opt/chromedriver
RUN chmod +x /opt/chromedriver/chromedriver
RUN ln -fs /opt/chromedriver/chromedriver /usr/local/bin/chromedriver

RUN export PATH=/usr/local/bin/chromedriver:$PATH

RUN robot -d NexusWebMeet/TestSuites

