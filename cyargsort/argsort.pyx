# distutils: language = c
# cython: cdivision = True
# cython: boundscheck = False
# cython: wraparound = False
# cython: profile = False

cimport numpy as np
import numpy as np
from libc.stdlib cimport malloc, free
 
cdef extern from "stdlib.h":
    ctypedef void const_void "const void"
    void qsort(void *base, int nmemb, int size,
            int(*compar)(const_void *, const_void *)) nogil

cdef struct IndexedElement:
    np.ulong_t index
    np.float64_t value

cdef int _compare(const_void *a, const_void *b):
    cdef np.float64_t v = (<IndexedElement*> a).value-(<IndexedElement*> b).value
    if v < 0: return -1
    if v >= 0: return 1

cpdef argsort(np.float64_t[:] data, np.intp_t[:] order):
    cdef np.ulong_t i
    cdef np.ulong_t n = data.shape[0]
    
    # Allocate index tracking array.
    cdef IndexedElement *order_struct = <IndexedElement *> malloc(n * sizeof(IndexedElement))
    
    # Copy data into index tracking array.
    for i in range(n):
        order_struct[i].index = i
        order_struct[i].value = data[i]
        
    # Sort index tracking array.
    qsort(<void *> order_struct, n, sizeof(IndexedElement), _compare)
    
    # Copy indices from index tracking array to output array.
    for i in range(n):
        order[i] = order_struct[i].index
        
    # Free index tracking array.
    free(order_struct)
    

        

