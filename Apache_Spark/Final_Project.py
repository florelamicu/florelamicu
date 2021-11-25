#!/usr/bin/env python3
# -*- coding: utf-8 -*-


from email.parser import Parser
import re
import time
from datetime import datetime, timezone, timedelta

def date_to_dt(date):
    def to_dt(tms):
        def tz():
            return timezone(timedelta(seconds=tms.tm_gmtoff))
        return datetime(tms.tm_year, tms.tm_mon, tms.tm_mday, 
                      tms.tm_hour, tms.tm_min, tms.tm_sec, 
                      tzinfo=tz())
    return to_dt(time.strptime(date[:-6], '%a, %d %b %Y %H:%M:%S %z'))


# /!\ All functions below must return an RDD object /!\

# T1: replace pass with your code
def extract_email_network(rdd):
    email_regex="[\w!#$%&'*+-/=?^_`{|}~.]+@enron.com"
    valid_ea=lambda _: 0 if re.compile(email_regex).fullmatch(_)==None else 1
    dup=lambda _: 0 if _[0]==_[1] else 1
    rdd1=rdd.map(lambda x:(Parser().parsestr(x)))\
    .map(lambda x: (x.get('From'),[x.get('To'),x.get('Cc'),x.get('Bcc')],date_to_dt(x.get('Date'))))\
    .map(lambda x:(x[0], (str(x[1][0])+','+str(x[1][1])+','+str(x[1][2])), x[2]))\
    .map(lambda x:(x[0], x[1].split(','), x[2])).flatMap(lambda x:[(x[0], _.strip(), x[2]) for _ in x[1]])\
    .filter(lambda x: valid_ea(x[0])).filter(lambda x: valid_ea(x[1])).filter(lambda x: dup(x)).distinct()
    return rdd1

# T2: replace pass with your code            
def get_monthly_contacts(rdd):
    rdd2=rdd.map(lambda x:(str(x[0])+', '+str(x[2].month)+'/'+str(x[2].year), x[1]))\
    .groupByKey().mapValues(list).map(lambda x:(x[0], len(set(x[1])))).map(lambda x:(x[0].split(','), x[1]))\
    .map(lambda x:(x[0][0], (x[0][1].strip(), x[1]))).groupByKey().mapValues(list)\
    .map(lambda x:(x[0], max(x[1], key=lambda _:_[1]))).map(lambda x:(x[0], x[1][0], x[1][1]))\
    .sortBy(lambda x:x[0], ascending=False).sortBy(lambda x:x[2], ascending=False)
    return rdd2

# T3: replace pass with your code
def convert_to_weighted_network(rdd, drange=None):
    if (drange):
        if drange[0]>drange[1]:
            rdd3=rdd.filter(lambda x:x[2] >= drange[1] and x[2] <= drange[0]).map(lambda x:((x[0],x[1]),1))\
            .reduceByKey(lambda a,b:a+b).map(lambda x:(x[0][0],x[0][1],x[1]))
        else:
            rdd3=rdd.filter(lambda x:x[2] <= drange[1] and x[2] >= drange[0])\
            .map(lambda x:((x[0],x[1]),1)).reduceByKey(lambda a,b:a+b).map(lambda x:(x[0][0],x[0][1],x[1]))
    else:
        rdd3=rdd.map(lambda x:((x[0],x[1]),1)).reduceByKey(lambda a,b:a+b).map(lambda x:(x[0][0],x[0][1],x[1]))
    return rdd3

# T4.1: replace pass with your code
def get_out_degrees(rdd):
    rdd4_11=rdd.map(lambda x: (x[0],x[2]))
    rdd4_12=rdd.map(lambda x: (x[1],0))
    rdd41=rdd4_12.union(rdd4_11).reduceByKey(lambda x,y: x+y).map(lambda x: (x[1],x[0]))\
    .sortBy(lambda x: (x[0],x[1]),0)
    return rdd41

# T4.2: replace pass with your code         
def get_in_degrees(rdd):
    rdd4_21=rdd.map(lambda x: (x[1],x[2]))
    rdd4_22=rdd.map(lambda x: (x[0],0))
    rdd42=rdd4_21.union(rdd4_22).reduceByKey(lambda x,y: x+y).map(lambda x: (x[1],x[0])).sortBy(lambda x: (x[0],x[1]),False)
    return rdd42