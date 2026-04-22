#!/bin/bash
sed -i 's/import java.util.ArrayList;/import java.util.ArrayList;\nimport java.util.List;\nimport java.util.regex.PatternSyntaxException;/g' src/main/java/io/github/dsheirer/gui/LogsPanel.java
