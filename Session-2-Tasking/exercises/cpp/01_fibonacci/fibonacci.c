/*
 *  OpenMP lecture exercises
 *  Copyright (C) 2011 by Christian Terboven <terboven@rz.rwth-aachen.de>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 *
 */

#include <stdio.h>
#include <omp.h>


int fib(int n)
{
  int x, y;
  if (n < 2)
    return n;
  //canot have a task group them(task wait cannot wait for grandchild), but use taskgroup to get rid of wait is OK
#pragma omp taskgroup
  {
  #pragma omp task shared(x) final(n<30)
  {
  x = fib(n - 1);
  }
  #pragma omp task shared(y) final(n<30)
  {
  y = fib(n - 2); 
  }
  }
  return x+y;

}


int main()
{
  int n,fibonacci;
  double starttime;
  printf("Please insert n, to calculate fib(n): \n");
  scanf("%d",&n);
  starttime=omp_get_wtime();
  #pragma omp parallel
  {
  #pragma omp single
  {
  fibonacci=fib(n);
  }
  }
  printf("fib(%d)=%d \n",n,fibonacci);
  printf("calculation took %lf sec\n",omp_get_wtime()-starttime);
  return 0;
}
