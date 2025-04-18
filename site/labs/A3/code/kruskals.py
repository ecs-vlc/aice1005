import numpy as np
import matplotlib.pyplot as plt
fig, ax = plt.subplots()
ax.set_aspect('equal', adjustable='datalim')
plt.title("Kruskal's Algorithm")
plt.plot([19.9987,47.8877],[9.7727,37.3609], "ro-", zorder=0, linewidth=1)
plt.plot([19.9987,-15.8174],[9.7727,15.0251], "ro-", zorder=0, linewidth=1)
plt.plot([19.9987,-11.3191],[9.7727,40.9593], "ro-", zorder=0, linewidth=1)
plt.plot([19.9987,41.5958],[9.7727,-2.98699], "ro-", zorder=0, linewidth=1)
plt.plot([19.9987,5.1324],[9.7727,-29.3398], "ro-", zorder=0, linewidth=1)
plt.plot([19.9987,27.6091],[9.7727,-16.3984], "ro-", zorder=0, linewidth=1)
plt.plot([19.9987,-19.6677],[9.7727,-12.703], "ro-", zorder=0, linewidth=1)
plt.plot([-11.3191,-38.1765],[40.9593,49.2957], "ro-", zorder=0, linewidth=1)
plt.plot([-11.3191,47.8877],[40.9593,37.3609], "ro-", zorder=0, linewidth=1)
plt.plot([-11.3191,-15.8174],[40.9593,15.0251], "ro-", zorder=0, linewidth=1)
plt.plot([48.647,27.353],[-40.1251,-37.9995], "ro-", zorder=0, linewidth=1)
plt.plot([48.647,41.5958],[-40.1251,-2.98699], "ro-", zorder=0, linewidth=1)
plt.plot([47.8877,-15.8174],[37.3609,15.0251], "ro-", zorder=0, linewidth=1)
plt.plot([47.8877,41.5958],[37.3609,-2.98699], "ro-", zorder=0, linewidth=1)
plt.plot([41.5958,27.6091],[-2.98699,-16.3984], "ro-", zorder=0, linewidth=1)
plt.plot([27.6091,5.1324],[-16.3984,-29.3398], "ro-", zorder=0, linewidth=1)
plt.plot([27.6091,-15.8174],[-16.3984,15.0251], "ro-", zorder=0, linewidth=1)
plt.plot([27.6091,27.353],[-16.3984,-37.9995], "ro-", zorder=0, linewidth=1)
plt.plot([-41.5978,-19.6677],[4.03539,-12.703], "ro-", zorder=0, linewidth=1)
plt.plot([-41.5978,-15.8174],[4.03539,15.0251], "ro-", zorder=0, linewidth=1)
plt.plot([-41.5978,-38.1765],[4.03539,49.2957], "ro-", zorder=0, linewidth=1)
plt.plot([-41.5978,-40.0239],[4.03539,-25.8923], "ro-", zorder=0, linewidth=1)
plt.plot([27.353,5.1324],[-37.9995,-29.3398], "ro-", zorder=0, linewidth=1)
plt.plot([-40.0239,-37.0789],[-25.8923,-49.7424], "ro-", zorder=0, linewidth=1)
plt.plot([-40.0239,-15.5815],[-25.8923,-37.132], "ro-", zorder=0, linewidth=1)
plt.plot([-40.0239,-19.6677],[-25.8923,-12.703], "ro-", zorder=0, linewidth=1)
plt.plot([-37.0789,-15.5815],[-49.7424,-37.132], "ro-", zorder=0, linewidth=1)
plt.plot([-15.5815,-19.6677],[-37.132,-12.703], "ro-", zorder=0, linewidth=1)
plt.plot([-15.5815,5.1324],[-37.132,-29.3398], "ro-", zorder=0, linewidth=1)
plt.plot([-19.6677,5.1324],[-12.703,-29.3398], "ro-", zorder=0, linewidth=1)
plt.plot([-19.6677,-15.8174],[-12.703,15.0251], "ro-", zorder=0, linewidth=1)
plt.plot([-38.1765,-15.8174],[49.2957,15.0251], "ro-", zorder=0, linewidth=1)
plt.plot([-15.8174,5.1324],[15.0251,-29.3398], "ro-", zorder=0, linewidth=1)
cir = plt.Circle((19.9987,9.7727), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(19.9987,9.7727,0, ha="center", ma="center", va="center", zorder=3)
cir = plt.Circle((-11.3191,40.9593), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(-11.3191,40.9593,1, ha="center", ma="center", va="center", zorder=3)
cir = plt.Circle((48.647,-40.1251), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(48.647,-40.1251,2, ha="center", ma="center", va="center", zorder=3)
cir = plt.Circle((47.8877,37.3609), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(47.8877,37.3609,3, ha="center", ma="center", va="center", zorder=3)
cir = plt.Circle((41.5958,-2.98699), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(41.5958,-2.98699,4, ha="center", ma="center", va="center", zorder=3)
cir = plt.Circle((27.6091,-16.3984), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(27.6091,-16.3984,5, ha="center", ma="center", va="center", zorder=3)
cir = plt.Circle((-41.5978,4.03539), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(-41.5978,4.03539,6, ha="center", ma="center", va="center", zorder=3)
cir = plt.Circle((27.353,-37.9995), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(27.353,-37.9995,7, ha="center", ma="center", va="center", zorder=3)
cir = plt.Circle((-40.0239,-25.8923), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(-40.0239,-25.8923,8, ha="center", ma="center", va="center", zorder=3)
cir = plt.Circle((-37.0789,-49.7424), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(-37.0789,-49.7424,9, ha="center", ma="center", va="center", zorder=3)
cir = plt.Circle((-15.5815,-37.132), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(-15.5815,-37.132,10, ha="center", ma="center", va="center", zorder=3)
cir = plt.Circle((-19.6677,-12.703), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(-19.6677,-12.703,11, ha="center", ma="center", va="center", zorder=3)
cir = plt.Circle((-38.1765,49.2957), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(-38.1765,49.2957,12, ha="center", ma="center", va="center", zorder=3)
cir = plt.Circle((-15.8174,15.0251), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(-15.8174,15.0251,13, ha="center", ma="center", va="center", zorder=3)
cir = plt.Circle((5.1324,-29.3398), 5, color="red", fill=True, zorder=2)
ax.add_patch(cir)
plt.text(5.1324,-29.3398,14, ha="center", ma="center", va="center", zorder=3)
plt.show()
