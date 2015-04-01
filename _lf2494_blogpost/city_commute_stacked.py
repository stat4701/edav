import numpy as np
import matplotlib.pyplot as plt

N = 8
Drive   = np.array([50, 72, 80, 38, 35, 17, 80, 57])
Carpool = np.array([12, 5, 7, 7, 4, 3, 14, 12])
Public  = np.array([30, 14, 7, 40, 43, 67, 5, 17])
Walk 	= np.array([3, 2, 1, 5, 12, 8, 0, 7])
Bike    = np.array([5, 7, 5, 10, 6, 5, 1, 7])

ind = np.arange(N)    # the x locations for the groups
width = 0.35       # the width of the bars: can also be len(x) sequence

print ind

p1 = plt.bar(ind, Drive,   width, color='r')
p2 = plt.bar(ind, Carpool, width, color='y',bottom=sum([Drive]))
p3 = plt.bar(ind, Public, width, color='g', bottom=sum([Drive, Carpool]))
p4 = plt.bar(ind, Walk, width, color='b' , bottom=sum([Drive, Carpool, Public]))
p5 = plt.bar(ind, Bike, width, color='k', bottom=sum([Drive, Carpool, Public, Walk]))

plt.ylabel('Percentage')
plt.title('Communters to Works')
plt.xticks(ind+width/2., ('CHI', 'ATL', 'LA', 'SF', 'DC', 'NYC', 'HOU', 'SEA') )
plt.yticks(np.arange(0,150,10))
plt.legend( (p1[0], p2[0], p3[0], p4[0], p5[0]), ('Drive', 'Carpool', 'Public', 'Walk', 'Bike') )

plt.show()
