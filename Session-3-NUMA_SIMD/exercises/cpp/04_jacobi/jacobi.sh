#!/bin/bash

# thread-placement options: cores, threads, sockets
export OMP_PLACES=sockets 
echo Thread Placement: ${OMP_PLACES}

# thread-binding options: close, spread
export OMP_PROC_BIND=spread
echo Thread Binding Policy: ${OMP_PROC_BIND}

NTHREADS="1 2 3 4 6 8 12"
for i in $NTHREADS
do
    echo Number of Threads = $i
    OMP_NUM_THREADS=$i make -s run
    echo
done
