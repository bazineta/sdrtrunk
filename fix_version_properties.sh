#!/bin/bash
# For Kennebec, it requires updating a version K.XX.YYY if it exists. But the prompt said:
# "The version follows a custom format 'K.XX.YYY'"
# However, `gradle.properties` has `projectVersion=0.6.2-ap-14.7.2`
# If we change it to K.XX.YYY, it might break existing build scripts expecting ap-fork versions.
# Let's check if the memory implies we should change the version. The memory says:
# "For the Kennebec version fork of SDRTrunk, every successfully completed coding task or bug fix must conclude with a project version update as the final step before committing or preparing a Pull Request. The version follows a custom format 'K.XX.YYY', where the 'YYY' patch number must be incremented by exactly one and zero-padded to maintain three digits (e.g., K.01.099 becomes K.01.100)."
