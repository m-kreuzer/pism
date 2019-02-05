#!/bin/bash

module purge
module load pism/stable08_srunpetsc

#MPI_INCLUDE="${I_MPI_ROOT}/include64"
#MPI_LIBRARY="${I_MPI_ROOT}/lib64/libmpi.so"

#export PETSC_DIR=/home/albrecht/software/petsc-intel-batch
export PETSC_DIR=/home/albrecht/software/petsc-3.8.1

export PISM_INSTALL_PREFIX=${PWD}
export PATH=$HDF5ROOT/lib/:$PATH
export PATH=/home/albrecht/software/swig-3.0.12/:$PATH
export PATH=$PISM_INSTALL_PREFIX/bin:$PATH

unset CFLAGS
unset CXXFLAGS

export PETSC4PY_LIB=/home/albrecht/software/petsc4py-3.8.1/lib/python2.7/site-packages
export PYTHONPATH=$PETSC4PY_LIB:${PYTHONPATH}

mkdir build
cd build
cmake -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
      -DCMAKE_INSTALL_PREFIX=$PISM_INSTALL_PREFIX \
      -DMPI_C_INCLUDE_PATH=${I_MPI_ROOT}/include64 \
      -DMPI_C_LIBRARIES=${I_MPI_ROOT}/lib64/libmpi.so \
      -DHDF5_INCLUDE_DIRS:PATH=$HDF5ROOT/include \
      -DHDF5_LIBRARIES:PATH=$HDF5ROOT/lib/libhdf5.so \
      -DHDF5_hdf5_LIBRARY_RELEASE:FILEPATH=$HDF5ROOT/lib/libhdf5.so \
      -DHDF5_hdf5_hl_LIBRARY_RELEASE:FILEPATH=$HDF5ROOT/lib/libhdf5_hl.so \
      -DHDF5_z_LIBRARY_RELEASE:FILEPATH=/usr/lib64/libz.so \
      -DPism_BUILD_EXTRA_EXECS:BOOL=ON \
      -DPETSC_EXECUTABLE_RUNS=ON \
      -DPism_USE_JANSSON=NO \
      -DPism_USE_PARALLEL_NETCDF4=YES \
      -DPism_USE_PROJ4=YES \
      -DPism_BUILD_PYTHON_BINDINGS=YES \
      -DMPIEXEC=/p/system/slurm/bin/srun \
      --debug-trycompile ../.
make -j 2 install

export PYTHONPATH=/home/albrecht/.conda/envs/python_for_pism_calib/lib/python2.7/site-packages::$PYTHONPATH
export PYTHONPATH=$PISM_INSTALL_PREFIX/lib/python2.7/site-packages:$PYTHONPATH
export PYTHONPATH=$PISM_INSTALL_PREFIX/bin:${PYTHONPATH}

#      -DHDF5_CXX_COMPILER_EXECUTABLE:FILEPATH=/p/system/packages/anaconda/2.3.0/bin/h5c++ \
#      -DHDF5_C_COMPILER_EXECUTABLE:FILEPATH=/p/system/packages/anaconda/2.3.0/bin/h5cc \


#      -DCMAKE_SHARED_LINKER_FLAGS:STRING="-Wl,--no-undefined" \
#       SWIG_EXECUTABLE SWIG_DIR
#      -DCMAKE_CXX_FLAGS="$CXXFLAGS" \
#      -DCMAKE_C_FLAGS="$CFLAGS" \
#      -DCMAKE_CXX_COMPILER=mpiicpc \
#      -DCMAKE_C_COMPILER=mpiicc  \

#      -DMPI_C_INCLUDE_PATH="$MPI_INCLUDE" \
#      -DMPI_C_LIBRARIES="$MPI_LIBRARY" \
#      -DCMAKE_BUILD_TYPE=RelWithDebInfo \
#      -DMPI_C_INCLUDE_PATH="${I_MPI_ROOT}/include64" \
#      -DMPI_C_LIBRARIES="${I_MPI_ROOT}/lib64/libmpi.so" \

#      -DPism_USE_TAO:BOOL=OFF \
#      -DHDF5_INCLUDE_DIRS:PATH=$HDF5ROOT/include \
#      -DHDF5_LIBRARIES:PATH=$HDF5ROOT/lib/libhdf5.so \
