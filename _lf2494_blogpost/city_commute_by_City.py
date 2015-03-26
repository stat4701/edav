import numpy as np
import matplotlib.pyplot as plt

opacity = 0.4


CHI = np.array([50,12,30,3,5])
ATL = np.array([72,5,14,2,7])
LA = np.array([80,7,7,1,5])
SF = np.array([38,7,40,5,10])
DC = np.array([35,4,43,12,6])
NYC = np.array([17,3,67,8,5])
HOU = np.array([80,14,5,0,1])
SEA = np.array([57,12,17,7,7])

N = 5
ind = np.arange(N)    # the x locations for the groups
width = 0.70       # the width of the bars: can also be len(x) sequence


p1 = plt.bar(ind, CHI,   width, color='r',alpha=opacity)
p2 = plt.bar(ind, ATL, width, color='y',alpha=opacity,bottom=sum([CHI]))
p3 = plt.bar(ind, LA, width, color='g',alpha=opacity, bottom=sum([CHI, ATL]))
p4 = plt.bar(ind, SF, width, color='b' ,alpha=opacity, bottom=sum([CHI, ATL, LA]))
p5 = plt.bar(ind, DC, width, color='k',alpha=opacity, bottom=sum([CHI, ATL, LA, SF]))
p6 = plt.bar(ind, NYC, width, color='c',alpha=opacity, bottom=sum([CHI, ATL, LA, SF, DC]))
p7 = plt.bar(ind, HOU, width, color='m',alpha=opacity, bottom=sum([CHI, ATL, LA, SF, DC, NYC]))
p8 = plt.bar(ind, SEA, width, color='r', bottom=sum([CHI, ATL, LA, SF, DC, NYC, HOU]))


plt.ylabel('Percentage')
plt.title('Communters to Works')
plt.xticks(ind+width/2., ('Drive', 'Carpool', 'Public', 'WAlk', 'Bike') )
plt.yticks(np.arange(0,500,50))
plt.legend( (p1[0], p2[0], p3[0], p4[0], p5[0], p6[0], p7[0], p8[0]), ('CHI', 'ATL', 'LA', 'SF', 'DC', 'NYC', 'HOU', 'SEA') )

fig, ax = plt.subplots()

index = np.arange(N)
bar_width = 0.10


error_config = {'ecolor': '0.3'}

rects1 = plt.bar(index, CHI, bar_width,
                 alpha=opacity,
                 color='r',
                 error_kw=error_config,
                 label='CHI')

rects2 = plt.bar(index + bar_width, ATL, bar_width,
                 alpha=opacity,
                 color='y',
                 error_kw=error_config,
                 label='ATL')


rects3 = plt.bar(index + (bar_width*2), LA, bar_width,
                 alpha=opacity,
                 color='g',
                 error_kw=error_config,
                 label='LA')

rects4 = plt.bar(index + (bar_width*3), SF, bar_width,
                 alpha=opacity,
                 color='b',
                 error_kw=error_config,
                 label='SF')

rects5 = plt.bar(index + (bar_width*4), DC, bar_width,
                 alpha=opacity,
                 color='k',
                 error_kw=error_config,
                 label='DC')


rects6 = plt.bar(index + (bar_width*5), NYC, bar_width,
                 alpha=opacity,
                 color='c',
                 error_kw=error_config,
                 label='NYC')

rects7 = plt.bar(index + (bar_width*6), HOU, bar_width,
                 alpha=opacity,
                 color='m',
                 error_kw=error_config,
                 label='HOU')


rects8 = plt.bar(index + (bar_width*7), SEA, bar_width,
                 color='r',
                 error_kw=error_config,
                 label='SEA')

plt.xlabel('Method')
plt.ylabel('Percentages')
plt.title('Communters to Work')
plt.xticks(index + bar_width, ('Drive', 'Carpool', 'Public', 'WAlk', 'Bike'))
plt.legend()

fig, ax = plt.subplots()
plt.show()
