#!/bin/sh
set -u
####################################
# set up GW runs with YAML file
####################################
# Code
HOMEgfs=${1:-${PWD}/../}
YAML=./yamls/C96mx100_S2S_CPC_ICS.yaml
export HPC_ACCOUNT=fv3-cpu

########################
# for hera/ursa
export TOPICDIR=/scratch4/NCEPDEV/global/Yangxing.Zheng/ICs/
export RUNTESTS=/scratch4/NCEPDEV/stmp/$USER
########################
# exp name
export pslot=c96sfs_test
########################
source ${HOMEgfs}/dev/ush/gw_setup.sh
echo $HPC_ACCOUNT
${HOMEgfs}/dev/workflow/create_experiment.py -y "${YAML}"

