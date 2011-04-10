#/usr/bin/env python
# Solution to problem http://goo.gl/Utq2M
# write a main :) 
# works for both given inputs large and small.

f=open('input.txt')
noTestCases = int(f.readline())

def calcIntersections(bldgA,map):
    bldgA.sort(reverse=True)
    result=0
    for index, value in enumerate(bldgA):
        b=map[value]
        for bpoints in bldgA[index+1:]:
            if map[bpoints]> b:
                result=result+1
    return result            

for i in range(1,noTestCases+1):
    bldgA=[]
    refMap={}
    noCables=int(f.readline())
    for ii in range(0,noCables):
        # find a better sugary syntax for this.
        temp=f.readline().split(" ")
        a=int(temp[0])
        b=int(temp[1])  
        bldgA.append(a)
        refMap[a]=b
        
    print "Case #%d: %d" %(i,calcIntersections(bldgA,refMap))
f.close()
