# distutils: language = c
# cython: cdivision = True
# cython: boundscheck = False
# cython: wraparound = False
# cython: profile = False

cimport numpy as cnp
import numpy as np
from libc.stdlib cimport malloc, free
from cython cimport view
cnp.import_array()
 
ctypedef cnp.float64_t FLOAT_t
ctypedef cnp.intp_t INT_t
ctypedef cnp.ulong_t INDEX_t
ctypedef cnp.uint8_t BOOL_t

cdef extern from "stdlib.h":
    ctypedef void const_void "const void"
    void qsort(void *base, int nmemb, int size,
            int(*compar)(const_void *, const_void *)) nogil

cdef struct Sorter:
    INT_t index
    FLOAT_t value

cdef int _compare(const_void *a, const_void *b):
    cdef FLOAT_t v = ((<Sorter*>a)).value-((<Sorter*>b)).value
    if v < 0: return -1
    if v >= 0: return 1

cdef void cyargsort(FLOAT_t[:] data, Sorter * order):
    cdef INT_t i
    cdef INT_t n = data.shape[0]
    for i in range(n):
        order[i].index = i
        order[i].value = data[i]
    qsort(<void *> order, n, sizeof(Sorter), _compare)
    
cpdef argsort(FLOAT_t[:] data, INT_t[:] order):
    cdef INT_t i
    cdef INT_t n = data.shape[0]
    cdef Sorter *order_struct = <Sorter *> malloc(n * sizeof(Sorter))
    cyargsort(data, order_struct)
    for i in range(n):
        order[i] = order_struct[i].index
    free(order_struct)
    

        

