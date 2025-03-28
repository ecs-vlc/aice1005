import matplotlib.pyplot as plt
import matplotlib

font = {'size'   : 18}

matplotlib.rc('font', **font)


with open("heapSortTiming.dat", "r") as f:
    data = f.read()

data = data.split('\n')
print(data)
x = [float(row.split(' ')[0]) for row in data]
print(x)
y = [float(row.split(' ')[1]) for row in data]
dy = [float(row.split(' ')[2]) for row in data]
print(y)
print(dy)

fig = plt.figure()

ax1 = fig.add_subplot(111)

ax1.set_title("Execuation Time for Heap Sort")    
ax1.set_xlabel("Input size $n$")
ax1.set_ylabel('$T(n)/n \quad (\mu\, sec$)')

ax1.errorbar(x,y, yerr=dy, capsize=3, c='r', label='the data')
ax1.set_xscale('log')
ax1.set_aspect(5)
plt.show()
fig.savefig('heapSortTimings.pdf')
