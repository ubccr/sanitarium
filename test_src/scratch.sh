#!/bin/bash

trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT
set -e

# Test writing to local scratch on the node
echo "${TMPDIR} - ccr sanitarium" > "${TMPDIR}/${SLURM_JOB_ID}-scratch-test.txt"
cat "${TMPDIR}/${SLURM_JOB_ID}-scratch-test.txt"
rm -f "${TMPDIR}/${SLURM_JOB_ID}-scratch-test.txt"

# Test writing to global scratch
echo "${GLOBAL_SCRATCH} - ccr sanitarium" > "${GLOBAL_SCRATCH}/grp-ccradmintest/${SLURM_JOB_ID}-scratch-test.txt"
cat "${GLOBAL_SCRATCH}/grp-ccradmintest/${SLURM_JOB_ID}-scratch-test.txt"
rm -f "${GLOBAL_SCRATCH}/grp-ccradmintest/${SLURM_JOB_ID}-scratch-test.txt"

# Sleep for a bit show this job shows up in the queue
sleep 30
