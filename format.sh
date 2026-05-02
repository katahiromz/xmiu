#!/bin/bash
clang-format xmiu.cpp > xmiu-new.cpp
mv -f xmiu-new.cpp xmiu.cpp
