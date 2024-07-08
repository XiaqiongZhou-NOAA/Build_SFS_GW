#!/bin/sh
set -u
####################################
# set up GW runs with YAML file
# CI yamls can be found at ${HOMEgfs}/ci/cases/{pr/weekly}/
####################################
# Code
export IDATE=2022050100

HOMEgfs=${1:-${PWD}/../}
YAML=${2:-${HOMEgfs}/RUN/SFS.yaml}
export HPC_ACCOUNT=GFS-DEV

########################
# for hera
WORKDIR=/lfs/h2/emc/physics/noscrub/${USER}/para_gfs
export TOPICDIR=/lfs/h2/emc/physics/noscrub/xiaqiong.zhou/data/SFSICS

export TOPEXPDIR=${WORKDIR}/RUNS
export TOPCOMROOT=${WORKDIR}/RUNS/COMROOT

########################
# Check Code
[[ ! -d ${HOMEgfs} ]] && echo "code is not at ${HOMEgfs}" &&  exit 1
[[ ! -f ${YAML} ]] && echo "yaml file not at ${YAML}" &&  exit 1
echo "HOMEgfs: ${HOMEgfs}"
echo "YAML: ${YAML}"
export pslot=sfs_sigcld

source ${HOMEgfs}/workflow/gw_setup.sh
echo $HPC_ACCOUNT
${HOMEgfs}/workflow/create_experiment.py --yaml "${YAML}" 

################################################
# Soft link items into EXPDIR for easier development
cd ${TOPEXPDIR}/${pslot}
set +u
source ${TOPEXPDIR}/${pslot}/config.base
set -u
#ln -s ${RUNDIR} RUNDIR
ln -s ${HOMEgfs} GW-CODE
ln -s ${HOMEgfs}/parm/config ORIG_CONFIGS
ln -s ${COMROOT}/${PSLOT}/logs LOGS_COMROOT
ln -s ${HOMEgfs}/workflow/setup_xml.py . 
ln -s ${HOMEgfs}/workflow/rocoto_viewer.py .

################################################
# start rocotorun and add crontab
xml_file=${PWD}/${pslot}.xml && db_file=${PWD}/${pslot}.db && cron_file=${PWD}/${pslot}.crontab
rocotorun -d ${db_file} -w ${xml_file}
crontab -l | cat - ${cron_file} | crontab -
# echo crontab file
echo "db=${db_file}"
echo "xml=${xml_file}"
