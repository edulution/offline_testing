#!/bin/bash

# Restart testing server
forever stopall
forever start ~/.baseline_testing/index.js
forever logs 0
