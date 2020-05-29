export SPARK_DIST_CLASSPATH=$(hadoop classpath)
export SPARK_HISTORY_OPTS="-Dspark.history.fs.logDirectory=hdfs://namenode:9000/g6_directory"