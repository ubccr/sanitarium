#!/bin/bash

trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT
set -e

#DIAGS
#echo "TMPDIR=\"${TMPDIR}\""
#echo "SLURM_JOB_ID=\"${SLURM_JOB_ID}\""
#

#
# Test writing to local scratch on the node
#
local_scratch_testfile="${TMPDIR}/${SLURM_JOB_ID}-scratch-test.txt"
echo "Local Scratch test file \"${local_scratch_testfile}\""
echo "${TMPDIR} - ccr sanitarium" > "${local_scratch_testfile}"
cat "${local_scratch_testfile}"
rm -f "${local_scratch_testfile}"

#
# Test writing to global scratch
#
# Get the group for the global scratch test directory path
group="$(groups | sed 's/\s/\n/g' | grep ^grp- | while read group; do if [ -d ${GLOBAL_SCRATCH}/${group} ]; then   echo "${group}";   break; fi; done)"
#
if [ "${group}" != "" ]
then
  global_scratch_testfile="${GLOBAL_SCRATCH}/${group}/${SLURM_JOB_ID}-scratch-test.txt"
  echo "Global Scratch test file \"${global_scratch_testfile}\""
  echo "${GLOBAL_SCRATCH} - ccr sanitarium" > "${global_scratch_testfile}"
  cat "${global_scratch_testfile}"
  # cleanup
  rm -f "${global_scratch_testfile}"
else
  echo "No Global scratch directory for the user ${LOGNAME}" >&2
fi

# Sleep for 30 seconds so this job shows up in the queue
for i in {1..15}
do
  echo -n "."
  sleep 2
done
echo

