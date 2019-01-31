
import numpy as np
from cyargsort.argsort import argsort
from cyargsort.pyargsort import pyargsort
import time

n = 10000000
data = np.random.normal(size=n)


time0 = time.time()
order = np.empty(shape=n,dtype=np.intp)
argsort(data, order)
time1 = time.time()
cython_time = time1 - time0

time0 = time.time()
np_order = np.argsort(data)
time1 = time.time()
np_time = time1 - time0

time0 = time.time()
py_order = np.empty(shape=n,dtype=np.intp)
pyargsort(data, py_order)
time1 = time.time()
py_time = time1 - time0

print('Cython time: %f' % cython_time)
print('Numpy time: %f' % np_time)
print('Python time: %f' % py_time)

assert np.all(order == np_order)
assert np.all(order == py_order)