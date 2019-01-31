import numpy as np


def pyargsort(data, order):
    order_arr = np.empty(shape=data.shape, dtype=object)
    for i in range(data.shape[0]):
        order_arr[i] = (data[i], i)
    
    order_arr.sort()
    
    for i in range(data.shape[0]):
        order[i] = order_arr[i][1]
    