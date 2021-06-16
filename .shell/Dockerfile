FROM amazonlinux:latest
ARG TERRAFORM_VERSION=0.15.1
ARG GH_VERSION=1.9.2
ARG KUBECTL_VERSION=1.18.9/2020-11-02
ARG HELM_VERSION=3.5.4
## SYSTEM SETUP
RUN yum update -y
RUN yum install -y sudo ps top
RUN yum install -y gcc g++ make git zip unzip tar bzip2 wget jq openssl uuid
## AWS CLI 
RUN wget --quiet "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -O ~/awscliv2.zip \
    && unzip ~/awscliv2.zip \
    && ./aws/install \
    && aws --version \
    && rm aws/install \
    && rm ~/awscliv2.zip
## TERRAFORM
RUN wget --progress=dot:mega https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
	&& unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
	&& mv terraform /usr/local/bin/ \
	&& rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
	&& chmod +x /usr/local/bin/terraform \
	&& terraform --version
## GITHUB CLI 
RUN wget --progress=dot:mega --no-check-certificate https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_amd64.tar.gz \
	&& tar -zxvf gh_${GH_VERSION}_linux_amd64.tar.gz \
	&& mv gh_${GH_VERSION}_linux_amd64/bin/gh /usr/local/bin/gh \
	&& rm gh_${GH_VERSION}_linux_amd64.tar.gz \
	&& rm -rf gh_${GH_VERSION}_linux_amd64 \
	&& chmod +x /usr/local/bin/gh \
	&& gh --version
## KUBECTL
RUN curl -o /usr/local/bin/kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
	&& chmod +x /usr/local/bin/kubectl \
	&& kubectl version --short --client
## HELM
RUN wget --progress=dot:mega https://get.helm.sh/helm-v3.5.4-linux-amd64.tar.gz \
	&& tar -zxvf helm-v${HELM_VERSION}-linux-amd64.tar.gz \
	&& mv linux-amd64/helm /usr/local/bin/helm \
	&& rm helm-v${HELM_VERSION}-linux-amd64.tar.gz \
	&& helm help
## EKS CLI
RUN curl -sSL "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /usr/local/bin \
	&& eksctl version

### USER Setup
RUN adduser developer 
RUN usermod -aG wheel developer
RUN echo '%developer ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
USER developer
