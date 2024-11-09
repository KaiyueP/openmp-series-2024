#NTHREADS="1 2 3 4 6 8 12 16 24 32 40 48"
NTHREADS="1 2 3 4 6 8 12 16"
for i in $NTHREADS
do
    echo Number of Threads = $i
    OMP_NUM_THREADS=$i make -s run
    echo
done

