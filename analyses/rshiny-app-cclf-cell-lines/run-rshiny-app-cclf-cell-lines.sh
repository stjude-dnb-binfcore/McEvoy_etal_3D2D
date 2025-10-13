#!/bin/bash

set -e
set -o pipefail

# set up running directory
cd "$(dirname "${BASH_SOURCE[0]}")" 
################################################################################################################
# Run module
Rscript --vanilla run-rshiny-app-cclf-cell-lines.R
################################################################################################################
