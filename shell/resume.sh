export NUTCH_HOME=/root/crawl/local
batchId=`cat $NUTCH_HOME/batchId.txt`
$NUTCH_HOME/bin/nutch fetch $batchId -resume
