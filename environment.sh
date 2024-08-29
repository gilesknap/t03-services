#!/bin/bash

# a bash script to source in order to set up your command line to in order
# to work with the t03 IOCs and Services.

# check we are sourced
if [ "$0" = "$BASH_SOURCE" ]; then
    echo "ERROR: Please source this script"
    exit 1
fi

echo "Loading environment for t03 IOC Instances and Services ..."

#### SECTION 1. Environment variables ##########################################

export EC_CLI_BACKEND="K8S"
# the namespace to use for kubernetes deployments
export EC_TARGET=t03-beamline
# the git repo for this project
export EC_SERVICES_REPO=https://github.com/gilesknap/t03-services
# declare your centralised log server Web UI
export EC_LOG_URL=""

#### SECTION 2. Install ec #####################################################

# check if epics-containers-cli (ec command) is installed
if ! ec --version &> /dev/null; then
    echo "ERROR: Please set up a virtual environment and: 'pip install edge-containers-cli'"
    return 1
fi

# enable shell completion for ec commands
source <(ec --show-completion ${SHELL})


#### SECTION 3. Configure Kubernetes Cluster ###################################


# TODO add commands here to enable kubectl to connect to the cluster


# enable shell completion for k8s tools
if [ -n "$ZSH_VERSION" ]; then SHELL=zsh; fi
source <(helm completion $(basename ${SHELL}))
source <(kubectl completion $(basename ${SHELL}))
