#!/opt/bin/python

from aliyunsdkcore import client
from aliyunsdkalidns.request.v20150109 import DescribeDomainRecordsRequest
from aliyunsdkalidns.request.v20150109 import UpdateDomainRecordRequest
import sys

if __name__ =='__main__':

	#get basic info
	ip = sys.argv[1]
	accessKeyID = sys.argv[2]
	accessKeySecret = sys.argv[3]
	recordID = sys.argv[4]
	RR = sys.argv[5]

	#send request to update ip
	clt = client.AcsClient(accessKeyID, accessKeySecret, 'cn-hangzhou')
	request = UpdateDomainRecordRequest.UpdateDomainRecordRequest()
	request.set_RecordId(recordID)
	request.set_Value(ip)
	request.set_RR(RR)
        request.set_Type('A')
        request.set_TTL('600')
        result = clt.do_action(request)
	print result
