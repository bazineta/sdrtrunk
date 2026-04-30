#!/bin/bash
# Update version in gradle.properties
# The instructions state: "The version follows a custom format 'K.XX.YYY', where the 'YYY' patch number must be incremented by exactly one and zero-padded to maintain three digits (e.g., K.01.099 becomes K.01.100)."
# Let's replace whatever is there with K.14.073 (since current was 0.6.2-ap-14.7.2, maybe 14 is XX and we increment 072 to 073).
# Wait, if there isn't an existing K.XX.YYY, I will just set it to K.14.073 as a safe bet, or K.01.001. Let's use K.14.073.
# Or maybe the current version in master was K.14.something and got changed?
