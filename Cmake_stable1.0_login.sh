#!/bin/bash

module purge
module load pism/stable1.0
#export PETSC_DIR=/home/albrecht/software/petsc-3.9.1
#export PETSC_ARCH=linux-intel-64bit

export PISM_INSTALL_PREFIX=${PWD}
export PATH=$HDF5ROOT/lib/:$PATH
export PATH=/p/system/packages/intel/parallel_studio_xe_2018_update1/compilers_and_libraries_2018.1.163/linux/compiler/lib/intel64:$PATH

#export PART='srun --partition=broadwell --exclusive --ntasks=1'
export PART=''
echo $PETSC_DIR
#module load zlib/1.2.11

# HDF5_C_LIBRARY_imf               HDF5_C_LIBRARY_imf-NOTFOUND                                                                                          
# HDF5_C_LIBRARY_iomp5             HDF5_C_LIBRARY_iomp5-NOTFOUND                                                                                        
# HDF5_C_LIBRARY_m                 /usr/lib64/libm.so                                                                                                   
# HDF5_C_LIBRARY_mkl_rt            HDF5_C_LIBRARY_mkl_rt-NOTFOUND                                                                                       
# HDF5_C_LIBRARY_sz                /p/system/packages/szip/2.1/lib/libsz.so                                                                             
# HDF5_C_LIBRARY_z                 HDF5_C_LIBRARY_z-NOTFOUND 

mkdir build
cd build
$PART  cmake -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
      -DCMAKE_INSTALL_PREFIX=$PISM_INSTALL_PREFIX \
      -DPism_BUILD_EXTRA_EXECS:BOOL=OFF \
      -DPETSC_EXECUTABLE_RUNS=ON \
      -DPism_USE_JANSSON=NO \
      -DPism_USE_PARALLEL_NETCDF4=YES \
      -DPism_USE_PROJ4=YES \
      -DMPIEXEC=/p/system/slurm/bin/srun \
      -DHDF5_C_LIBRARY_z=$ZLIBROOT/lib/libz.so \
      -DHDF5_C_LIBRARY_mkl_rt=$MKLROOT/lib/intel64 \
      --debug-trycompile ../.
$PART make install
#make install -j 2
#      -DNCGEN_PROGRAM:FILEPATH=/home/albrecht/software/netcdf-intel-2018/bin/ncgen3 \
#      -DSPHINX_EXECUTABLE=/home/albrecht/software/sphinx-master \

#      -DCMAKE_CXX_FLAGS="$CXXFLAGS" \
#      -DCMAKE_C_FLAGS="$CFLAGS" \
#      -DCMAKE_CXX_COMPILER=mpiicpc \
#      -DCMAKE_C_COMPILER=mpiicc  \

#      -DMPI_C_INCLUDE_PATH="$MPI_INCLUDE" \
#      -DMPI_C_LIBRARIES="$MPI_LIBRARY" \
#      -DCMAKE_BUILD_TYPE=RelWithDebInfo \

#      -DPism_USE_TAO:BOOL=OFF \
#      -DHDF5_INCLUDE_DIRS:PATH=$HDF5ROOT/include \
#      -DHDF5_LIBRARIES:PATH=$HDF5ROOT/lib/libhdf5.so \

#       -DLATEX_COMPILER:FILEPATH=/p/system/packages/texlive/2017/bin/x86_64-pc-linux-gnu/ \
