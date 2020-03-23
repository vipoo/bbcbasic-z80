#!/bin/bash
set -xe

grep "HBIOS: BF_VDAIO" ../.full-test-output.txt > /dev/null
grep "HBIOS: BF_SYSGET, Subfunction: in C 50" ../.full-test-output.txt > /dev/null
