#!/bin/bash

export NUTCH_HOME=/root/crawl/local

#爬取周期
n=1

#每次爬取的链接数目
maxUrls=10000

#爬取线程
thread=10

#提交索引地址
solrUrl=http://localhost:8983/solr/

echo "starting mycrawl"

#切换到NUTCH_HOME
cd $NUTCH_HOME

#开始周期循环 
for (( i = 1 ; i <= $n ; i++ ))
do

    #根据当前时间设置batchId
    batchId=`date +%s`-$RANDOM
    echo "Generating batchId: "$batchId
    echo $batchId > batchId.txt
    
    
    echo "Generate "$maxUrls" urls."
    
    #生成爬取链接
    $NUTCH_HOME/bin/nutch generate  -topN $maxUrls -batchId $batchId 
    
    echo "Fetching."
    
    #爬取生成链接
    $NUTCH_HOME/bin/nutch fetch  $batchId -threads $thread
    
    echo "Parsing."
    
    #解析爬取内容
    $NUTCH_HOME/bin/nutch parse  $batchId 
    
    echo "Updating."
    
    #更新数据库
    $NUTCH_HOME/bin/nutch updatedb  
    echo " "
    
    #提交建立索引
    #$NUTCH_HOME/bin/nutch elasticindex nutch $batchId 

done

