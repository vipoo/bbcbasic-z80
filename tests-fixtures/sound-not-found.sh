#!/bin/bash
set -xe

./expect 0 'HBIOS: BF_SNDPIT'
./expect 0 'HBIOS: BF_SNDPIT'
./expect 0 'HBIOS: BF_SNDVOL'