#!/bin/bash

# Test writing to local scratch on the node
echo "$TMPDIR - ccr sanitarium" > $TMPDIR/scratch-test.txt
cat $TMPDIR/scratch-test.txt

# Test writing to global scratch
echo "$GLOBAL_SCRATCH - ccr sanitarium" > $GLOBAL_SCRATCH/${SLURM_JOB_ID}-scratch-test.txt
cat $GLOBAL_SCRATCH/${SLURM_JOB_ID}-scratch-test.txt

# Sleep for a bit show this job shows up in the queue
sleep 30
