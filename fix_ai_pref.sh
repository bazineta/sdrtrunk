#!/bin/bash
sed -i '/<<<<<<< HEAD/d' src/main/java/io/github/dsheirer/preference/ai/AIPreference.java
sed -i '/=======/d' src/main/java/io/github/dsheirer/preference/ai/AIPreference.java
sed -i '/>>>>>>> origin\/master/d' src/main/java/io/github/dsheirer/preference/ai/AIPreference.java
