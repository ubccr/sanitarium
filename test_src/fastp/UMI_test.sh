#!/bin/bash
fastp -i R1.fq -o out.R1.fq -U --umi_loc=read1 --umi_len=8
echo
diff out.R1.fq  out.R1.fq_expected
if [ "$?" = "0" ]
then
   echo "Success"
else
   echo "Fail!!!"
   exit 1
fi
