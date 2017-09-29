# -*- coding: utf-8 -*-
"""
Created on Sun Sep 17 21:13:19 2017

@author: zanol_000
"""

#!/usr/bin/env python

# import modules used here -- sys is a very standard one
import math
import random





def main():
    raw=int(input("Number of raw= "))
    column=int(input("Number of column= "))
    if raw==column:
      matrix=[[0 for j in range(column)] for i in range(raw)]
      note=[0 for i in range(raw)]
      var=[0 for i in range(raw)]
    else:
      return 0
    for i in range(raw):
        for j in range(column):
            matrix[i][j]=random.uniform(1, 100.0)
            ##matrix[i][j]=float(input("raw %d, column %d: " %(i,j)))
    print(matrix)
    
    for i in range(raw):
        note[i]=random.uniform(2.5, 10.0)
        ##note[i]=float(input("Termine noto %d: " %(i)))

##scaling -------------------------------------------------------
           
    for i in range(raw):
        subraw= [0 for co in range(column)]
        subnote=0
        print ("Elaborating " + str(i) )
        for i2 in range(i+1,raw):
          k=matrix[i2][i]/matrix[i][i]
          for j in range (column):
            subraw[j]=matrix[i][j]*k
          subnote=note[i]*k
          note[i2]-=subnote
          print ("subraw N"+ str(i2-1)+str(subraw))
          for j in range (column):
            matrix[i2][j]-=subraw[j]
            if math.fabs(matrix[i2][j])<=10e-13:
              matrix[i2][j]=0
          print ("MATRIX: " + str(matrix))
          
 ##scaling ------------------------------------------------------- 
 
    print ("TERMINI NOTI: "+ str(note))

##resolving ------------------------------------------------------        
    for i in range(raw-1,-1,-1):
        for j in range(column-1,i,-1):
            note[i]-=var[j]*matrix[i][j]
        var[i]=note[i]/matrix[i][i]
##resolving ------------------------------------------------------        
        
    print ("MATRIX: " + str(matrix))
    
    print ("")
    print ("")
    print ("")
    print ("RESULT: " + str(var))
    return matrix
        

p=main()