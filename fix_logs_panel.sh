#!/bin/bash
sed -i '/<<<<<<< HEAD/,/======={/d' src/main/java/io/github/dsheirer/gui/LogsPanel.java
sed -i '/>>>>>>> origin\/master/d' src/main/java/io/github/dsheirer/gui/LogsPanel.java
