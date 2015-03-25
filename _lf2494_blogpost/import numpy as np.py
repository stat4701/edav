import numpy as np
import matplotlib.pyplot as plt

N = 8
Drive   = np.array([50, 72, 80, 38, 35, 17, 80, 57])
Carpool = np.array([12, 5, 7, 7, 4, 3, 14, 12])
Public  = np.array([30, 14, 7, 40, 43, 67, 5, 17])
Walk 	= np.array([3, 2, 1, 5, 12, 8, 0, 7])
Bike    = np.array([5, 7, 5, 10, 6, 5, 1, 7])

opacity = 0.4

ind = np.arange(N)    # the x locations for the groups
width = 0.70       # the width of the bars: can also be len(x) sequence


p1 = plt.bar(ind, Drive,   width, color='r',alpha=opacity)
p2 = plt.bar(ind, Carpool, width, color='y',alpha=opacity,bottom=sum([Drive]))
p3 = plt.bar(ind, Public, width, color='g',alpha=opacity, bottom=sum([Drive, Carpool]))
p4 = plt.bar(ind, Walk, width, color='b' ,alpha=opacity, bottom=sum([Drive, Carpool, Public]))
p5 = plt.bar(ind, Bike, width, color='k',alpha=opacity, bottom=sum([Drive, Carpool, Public, Walk]))

plt.ylabel('Percentage')
plt.title('Communters to Works')
plt.xticks(ind+width/2., ('CHI', 'ATL', 'LA', 'SF', 'DC', 'NYC', 'HOU', 'SEA') )
plt.yticks(np.arange(0,150,10))
plt.legend( (p1[0], p2[0], p3[0], p4[0], p5[0]), ('Drive', 'Carpool', 'Public', 'Walk', 'Bike') )

fig, ax = plt.subplots()

index = np.arange(N)
bar_width = 0.18


error_config = {'ecolor': '0.3'}

rects1 = plt.bar(index, Drive, bar_width,
                 alpha=opacity,
                 color='r',
                 error_kw=error_config,
                 label='Drive')

rects2 = plt.bar(index + bar_width, Carpool, bar_width,
                 alpha=opacity,
                 color='y',
                 error_kw=error_config,
                 label='Carpool')


rects3 = plt.bar(index + (bar_width*2), Public, bar_width,
                 alpha=opacity,
                 color='g',
                 error_kw=error_config,
                 label='Public')

rects4 = plt.bar(index + (bar_width*3), Walk, bar_width,
                 alpha=opacity,
                 color='b',
                 error_kw=error_config,
                 label='Walk')

rects5 = plt.bar(index + (bar_width*4), Bike, bar_width,
                 alpha=opacity,
                 color='k',
                 error_kw=error_config,
                 label='Bike')

plt.xlabel('Cities')
plt.ylabel('Percentages')
plt.title('Communters to Work')
plt.xticks(index + bar_width, ('CHI', 'ATL', 'LA', 'SF', 'DC', 'NYC', 'HOU', 'SEA'))
plt.legend()

plt.tight_layout()
plt.show()