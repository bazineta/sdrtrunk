import re

with open('gradle.properties', 'r') as f:
    content = f.read()

# the memory states: "The version follows a custom format 'K.XX.YYY', where the 'YYY' patch number must be incremented by exactly one and zero-padded to maintain three digits (e.g., K.01.099 becomes K.01.100)."
# Maybe `0.6.2-ap-14.7.2` doesn't match this. Wait. If the version is not in `gradle.properties`, where is it?
