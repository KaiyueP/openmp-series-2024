#!/bin/bash
#SBATCH -C cpu
#SBATCH -N 1
#SBATCH -t 30:00
#SBATCH -q debug

cc -fopenmp -DSTREAM_ARRAY_SIZE=200000000 -mcmodel=medium -o stream_nft stream_nft.c

TIMESTAMP=`/bin/date +\%Y\%m\%d_\%H\%M`
myfile="mydata.$TIMESTAMP"
echo "myfile= " "$myfile" > $myfile
echo "-DSTREAM_ARRAY_SIZE=200000000" >> $myfile

echo "            " >> $myfile
echo "            " >> $myfile

echo "======================" >> $myfile
echo "Run Set 1" >> $myfile
echo "Running STREAM without first touch and OMP_PROC_BIND=close" >> $myfile
echo "export OMP_PROC_BIND=close" >> $myfile
echo "export OMP_PLACES=threads" >> $myfile
echo "======================" >> $myfile
echo "threads   Triad " >> $myfile
export OMP_PROC_BIND=close
export OMP_PLACES=threads

#for i in `seq 1 256`;
NTHREADS="1 2 4 8 16 32 48 64 96 128 160 192 224 256"
for i in $NTHREADS
do
   export OMP_NUM_THREADS=$i
   echo -n $OMP_NUM_THREADS "    " >> $myfile
   ./stream_nft -DSTREAM_ARRAY_SIZE=200000000 |grep Triad |awk '{print $2}' >> $myfile
done

echo "                    " >> $myfile
echo "======================" >> $myfile
echo "Run Set 2" >> myfile
echo "Running STREAM without first touch and OMP_PROC_BIND=spread" >> $myfile
echo "export OMP_PROC_BIND=spread" >> $myfile
echo "export OMP_PLACES=threads" >> $myfile
echo "======================" >> $myfile
echo "threads   Triad " >> $myfile
export OMP_PROC_BIND=spread
export OMP_PLACES=threads

#for i in `seq 1 256`;
for i in $NTHREADS
do
   export OMP_NUM_THREADS=$i
   echo -n $OMP_NUM_THREADS "    " >> $myfile
   ./stream_nft -DSTREAM_ARRAY_SIZE=200000000 |grep Triad |awk '{print $2}' >> $myfile
done
