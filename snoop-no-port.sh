#!/sbin/sh

#Usage /scripts/snoop-no-port.sh OCC-SRV01 1000
#Means snoop -ta -x 54 OCC-SRV01, run for 1000 seconds

NOWDATE=`date +%Y%m%d-%H%M`
NOWHOST=`hostname`
file=$NOWDATE-snoop-$1-$NOWHOST
echo $file
nohup  snoop -ta -x 54 $1 > /tmp/$file &
sleep $2
echo $!
kill -INT $!
gzip /tmp/$file
chmod 644 /tmp/$file.gz
cd /tmp
USER=hirman
PASSWD=hirman
SERVER=175.55.41.1
FILING=$file.gz
ftp -n -i $SERVER <<SCRIPT
user $USER $PASSWD
binary
prompt
put $FILING
bye
SCRIPT
rm /tmp/$file.gz
