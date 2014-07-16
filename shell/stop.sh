#!/bin/bash
`ps -ef | grep crawl.sh | grep -v grep | cut -c 9-15 | xargs kill -s 9`
`ps -ef | grep nutch | grep -v grep | cut -c 9-15 | xargs kill -s 9`
