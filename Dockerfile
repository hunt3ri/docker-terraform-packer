# Create docker container with Terraform installed, and suite of tools to ease working with AWS
FROM ubuntu:20.04

ENV TERRAFORM_VERSION 0.15.0
ENV TERRAFORM_URL https://releases.hashicorp.com/terraform/$TERRAFORM_VERSION/terraform_${TERRAFORM_VERSION}_linux_amd64.zip

ENV PACKER_VERSION 1.7.2
ENV PACKER_URL https://releases.hashicorp.com/packer/$PACKER_VERSION/packer_${PACKER_VERSION}_linux_amd64.zip

ENV AWSCLI_URL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip

# Install dependencies
RUN apt-get update && apt-get install -y \
    dos2unix \
    curl \
    figlet \
    git-core \
    python3-pip \
    vim \
    zip

# Set python aliases for python3 and upgrade pip
RUN echo 'alias python=python3' >> ~/.bashrc
RUN echo 'alias pip=pip3' >> ~/.bashrc
RUN pip3 install --upgrade pip

# Install python dependencies psycopg2 required by ansible for postgres config
RUN pip3 install ansible boto3 click psycopg2-binary

# Ensure python is included in path
ENV PATH="/usr/bin/python3:${PATH}"

# Install awscli
RUN curl -o /opt/awscliv2.zip $AWSCLI_URL && \
    unzip /opt/awscliv2.zip && \
    ./aws/install && \
    rm /opt/awscliv2.zip && \
    rm -Rf /opt/aws

# Install Terraform
RUN curl -o /root/terraform.zip $TERRAFORM_URL && \
   unzip /root/terraform.zip -d /usr/local/bin/ && \
   rm /root/terraform.zip

# Install Packer
RUN curl -o /root/packer.zip $PACKER_URL && \
   unzip /root/packer.zip -d /usr/local/bin/ && \
   rm /root/packer.zip
