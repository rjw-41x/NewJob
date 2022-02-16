import sys
from rockset import Client,ParamDict

# rs = Client(api_server='api.rs2.usw2.rockset.com', api_key='rsJKatr23akr52lu3mte_007rEcT42uwm914orc_FBcdD')

rs = Client()

# print( [vars(c) for c in rs.Collection.list() ] )

collection_name = 'movies'

try:
    collection = rs.Collection.create( collection_name )
except:
    collection = rs.Collection.retrieve( collection_name )

year=input("Enter the year you are interested in: ")
# print(type(year))
# print("*%s*" % year )
if year == '':
    year='2006'
# print( "Year is ", year )

qlambda=rs.QueryLambda.retrieveByVersion('TotRevPctByYear',version='4ce33dd332b389ad',workspace='commons')


params=ParamDict()

params['inYear']=year
# print( params )
iter=0
for result in qlambda.execute(parameters=params).results:
    iter=iter+1
    if iter == 1:
        for k in result:
            print('%-35s  ' % k, end='' )
        print()
        for v in result.values():
            print('%-35.35s   ' % v, end='' )
        print()
    else:
        for v in result.values():
            print('%-35.35s   ' % v, end='' )
        print()
    # print(result.keys())
    # print( result )
