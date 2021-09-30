#!/bin/bash

echo "Serial"
echo "Result;nx;elapsed time;num threads"

eps=0.000001
niter=1000

for i in 512 1024 2048; do
   ./serial $i $niter $eps
done
echo "Vectorized"
for i in 512 1024 2048; do
   ./vetorized $i $niter $eps
done
echo "Multithreaded"
for i in 512 1024 2048; do
    for j in 1 2 3 4 5 6 7 8;do
        export OMP_NUM_THREADS=$j
        ./threads $i $niter $eps
    done
done
echo "Vectorized and Multithreaded"
for i in 512 1024 2048; do
    for j in 1 2 3 4 5 6 7 8;do
        export OMP_NUM_THREADS=$j
        ./vetorized_threads $i $niter $eps
    done
done