#!/bin/sh
set -u
####################################
# set up GW runs with YAML file
####################################
# Code
HOMEgfs=${1:-${PWD}/../}
YAML=${2:-${HOMEgfs}/dev/ci/cases/sfs/C192mx025_S2S_CPC_ICS.yaml}
YAML=./C96mx100_S2S_CPC_ICS.yaml
YAML=${2:-${HOMEgfs}/dev/ci/cases/sfs/C96mx100_S2S.yaml}
YAML=./yamls/C192mx025_S2S_CPC_ICS.yaml
YAML=./yamls/C192mx025_S2S_REPLAY_ICS.yaml
export HPC_ACCOUNT=fv3-cpu

########################
# for hera
export TOPICDIR=/scratch4/NCEPDEV/global/Yangxing.Zheng/ICs/
# for gaea

export RUNTESTS=/scratch4/NCEPDEV/stmp/$USER

########################
# Check Code
[[ ! -d ${HOMEgfs} ]] && echo "code is not at ${HOMEgfs}" &&  exit 1
[[ ! -f ${YAML} ]] && echo "yaml file not at ${YAML}" &&  exit 1

echo "HOMEgfs: ${HOMEgfs}"
echo "YAML: ${YAML}"
export pslot=c96sfs_test

source ${HOMEgfs}/dev/ush/gw_setup.sh
echo $HPC_ACCOUNT
${HOMEgfs}/dev/workflow/create_experiment.py -y "${YAML}"

