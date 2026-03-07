#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define the main class to execute
MAIN_CLASS="org.benchmark.runner.BenchmarkRunner"
# Define the target submodule
MODULE="benchmark"

echo "Building the project using Maven Wrapper..."
./mvnw clean compile

echo "Starting the benchmark..."

#./mvnw exec:java clean install

# Pass the first script argument to the Java application
./mvnw exec:java -pl "${MODULE}" -Dexec.mainClass="${MAIN_CLASS}" -Dexec.args="$@"

ls -l `find . -type f -name "*jar-with-dependencies*"`

echo "Benchmark execution finished."