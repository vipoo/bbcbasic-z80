#!/bin/bash
set -xe

grep "HBIOS: BF_IOPORTS" ../.full-test-output.txt > /dev/null
grep "HBIOS: BF_SNDINI" ../.full-test-output.txt > /dev/null
