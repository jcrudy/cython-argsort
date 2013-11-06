
import numpy as np
import argsort
import time

n = 10000000
data = np.random.normal(size=n)
order = np.empty(shape=n,dtype=np.intp)

time0 = time.time()
argsort.argsort(data, order)
time1 = time.time()
cython_time = time1 - time0

time0 = time.time()
np_order = np.argsort(data)
time1 = time.time()
np_time = time1 - time0

print 'Cython time: %f' % cython_time
print 'Numpy time: %f' % np_time

assert np.all(order == np.argsort(data))