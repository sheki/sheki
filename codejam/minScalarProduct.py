#!/bin/env python
# Solution to http://goo.gl/qaSIS , attempt in python
# hackish in nature, not really organized
def minScalarProd(a,b):
    a.sort()
    b.sort(reverse=True)
    return scalarProd(a,b)

def scalarProd(a,b):
    if not a:
        return 0
    return a[0]*b[0] +scalarProd(a[1:],b[1:])

f=open('input.txt','r')
i=0
x=[]
y=[]
case=1
for line in f:
    if i==0:
        i=i+1
        continue
    if i%3==2  :
        x=[int(a) for a in line.split(" ")]
    if i%3==0:
        y=[int(a) for a in line.split(" ")]
        print "Case #%d: %d"%(case, minScalarProd(x,y))
        case=case+1
    i=i+1
f.close()
