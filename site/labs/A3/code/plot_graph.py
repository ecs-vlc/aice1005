import numpy as np
import matplotlib.pyplot as plt
fig, ax = plt.subplots()
ax.set_aspect('equal', adjustable='datalim')
plt.plot([23.1679,26.1573],[-23.8329,1.86038], "ro-", zorder=0)
plt.plot([23.1679,45.6909],[-23.8329,-22.5731], "ro-", zorder=0)
plt.plot([23.1679,45.7153],[-23.8329,-42.4895], "ro-", zorder=0)
plt.plot([23.1679,2.92114],[-23.8329,-22.0726], "ro-", zorder=0)
plt.plot([-39.1604,-20.007],[3.06725,9.15228], "ro-", zorder=0)
plt.plot([-39.1604,-32.6129],[3.06725,29.7395], "ro-", zorder=0)
plt.plot([-39.1604,-44.249],[3.06725,-31.4974], "ro-", zorder=0)
plt.plot([-22.0359,-44.249],[-22.975,-31.4974], "ro-", zorder=0)
plt.plot([-22.0359,-18.5571],[-22.975,-44.933], "ro-", zorder=0)
plt.plot([-22.0359,2.92114],[-22.975,-22.0726], "ro-", zorder=0)
plt.plot([-22.0359,9.87514],[-22.975,17.1777], "ro-", zorder=0)
plt.plot([-22.0359,-20.007],[-22.975,9.15228], "ro-", zorder=0)
plt.plot([9.87514,-20.007],[17.1777,9.15228], "ro-", zorder=0)
plt.plot([9.87514,-13.5688],[17.1777,41.0195], "ro-", zorder=0)
plt.plot([9.87514,38.0627],[17.1777,30.3007], "ro-", zorder=0)
plt.plot([9.87514,10.9716],[17.1777,37.6968], "ro-", zorder=0)
plt.plot([9.87514,-32.6129],[17.1777,29.7395], "ro-", zorder=0)
plt.plot([9.87514,2.92114],[17.1777,-22.0726], "ro-", zorder=0)
plt.plot([9.87514,26.1573],[17.1777,1.86038], "ro-", zorder=0)
plt.plot([-13.5688,10.9716],[41.0195,37.6968], "ro-", zorder=0)
plt.plot([-13.5688,-20.007],[41.0195,9.15228], "ro-", zorder=0)
plt.plot([-13.5688,-32.6129],[41.0195,29.7395], "ro-", zorder=0)
plt.plot([-32.6129,-20.007],[29.7395,9.15228], "ro-", zorder=0)
plt.plot([26.1573,2.92114],[1.86038,-22.0726], "ro-", zorder=0)
plt.plot([26.1573,38.0627],[1.86038,30.3007], "ro-", zorder=0)
plt.plot([26.1573,45.6909],[1.86038,-22.5731], "ro-", zorder=0)
plt.plot([45.7153,-18.5571],[-42.4895,-44.933], "ro-", zorder=0)
plt.plot([45.7153,45.6909],[-42.4895,-22.5731], "ro-", zorder=0)
plt.plot([-18.5571,2.92114],[-44.933,-22.0726], "ro-", zorder=0)
plt.plot([-18.5571,-44.249],[-44.933,-31.4974], "ro-", zorder=0)
plt.plot([-20.007,2.92114],[9.15228,-22.0726], "ro-", zorder=0)
plt.plot([10.9716,38.0627],[37.6968,30.3007], "ro-", zorder=0)
plt.plot([38.0627,45.6909],[30.3007,-22.5731], "ro-", zorder=0)
plt.plot([23.1679,26.1573],[-23.8329,1.86038], "b-", zorder=1)
plt.plot([23.1679,45.6909],[-23.8329,-22.5731], "b-", zorder=1)
plt.plot([23.1679,45.7153],[-23.8329,-42.4895], "b-", zorder=1)
plt.plot([23.1679,2.92114],[-23.8329,-22.0726], "b-", zorder=1)
cir = plt.Circle((23.1679,-23.8329), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(23.1679,-23.8329,0, ha="center", ma="center", va="center", zorder=3)
cir = plt.Circle((-39.1604,3.06725), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(-39.1604,3.06725,1, ha="center", ma="center", va="center", zorder=3)
cir = plt.Circle((-22.0359,-22.975), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(-22.0359,-22.975,2, ha="center", ma="center", va="center", zorder=3)
cir = plt.Circle((9.87514,17.1777), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(9.87514,17.1777,3, ha="center", ma="center", va="center", zorder=3)
cir = plt.Circle((-13.5688,41.0195), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(-13.5688,41.0195,4, ha="center", ma="center", va="center", zorder=3)
cir = plt.Circle((-32.6129,29.7395), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(-32.6129,29.7395,5, ha="center", ma="center", va="center", zorder=3)
cir = plt.Circle((26.1573,1.86038), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(26.1573,1.86038,6, ha="center", ma="center", va="center", zorder=3)
cir = plt.Circle((45.7153,-42.4895), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(45.7153,-42.4895,7, ha="center", ma="center", va="center", zorder=3)
cir = plt.Circle((-18.5571,-44.933), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(-18.5571,-44.933,8, ha="center", ma="center", va="center", zorder=3)
cir = plt.Circle((-20.007,9.15228), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(-20.007,9.15228,9, ha="center", ma="center", va="center", zorder=3)
cir = plt.Circle((10.9716,37.6968), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(10.9716,37.6968,10, ha="center", ma="center", va="center", zorder=3)
cir = plt.Circle((38.0627,30.3007), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(38.0627,30.3007,11, ha="center", ma="center", va="center", zorder=3)
cir = plt.Circle((-44.249,-31.4974), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(-44.249,-31.4974,12, ha="center", ma="center", va="center", zorder=3)
cir = plt.Circle((45.6909,-22.5731), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(45.6909,-22.5731,13, ha="center", ma="center", va="center", zorder=3)
cir = plt.Circle((2.92114,-22.0726), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(2.92114,-22.0726,14, ha="center", ma="center", va="center", zorder=3)
plt.show()
