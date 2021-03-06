#!/bin/bash
# Wealthsystems [[BDD Project]]
# Ricardo Johnny <ricardo.jesus@wssim.com.br>

pushd /root > /dev/null

if [ -d "persistent-hdfs" ]; then
  echo "Persistent HDFS seems to be installed. Exiting."
  return 0
fi

case "$HADOOP_MAJOR_VERSION" in
  1)
    wget http://s3.amazonaws.com/spark-related-packages/hadoop-1.0.4.tar.gz
    echo "Descompactando Hadoop"
    tar xvzf hadoop-1.0.4.tar.gz > /tmp/spark-ec2_hadoop.log
    rm hadoop-*.tar.gz
    mv hadoop-1.0.4/ persistent-hdfs/
    cp /root/hadoop-native/* /root/persistent-hdfs/lib/native/
    ;;
  yarn)
    wget http://s3.amazonaws.com/spark-related-packages/hadoop-2.7.3.tar.gz
    echo "Descompactando Hadoop"
    tar xvzf hadoop-*.tar.gz > /tmp/spark-ec2_hadoop.log
    rm hadoop-*.tar.gz
    mv hadoop-2.7.3/ persistent-hdfs/

    # Have single conf dir
    rm -rf /root/persistent-hdfs/etc/hadoop/
    ln -s /root/persistent-hdfs/conf /root/persistent-hdfs/etc/hadoop
    ;;

  *)
     echo "ERRO: Versao do Hadoop desconhecida"
     return 1
esac
/root/spark-ec2/copy-dir /root/persistent-hdfs

popd > /dev/null
