export LIBRARY_PATH="${LIBRARY_PATH:-}${LIBRARY_PATH:+:}/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib"
libompInstalledDir=$(brew --prefix libomp)
export CONDA_PYTHON_VERSION=3.11  # Adjust if needed

cmake \
-DFAISS_ENABLE_GPU=OFF \
-DBUILD_SHARED_LIBS=ON \
-DFAISS_ENABLE_PYTHON=ON \
-DCMAKE_BUILD_TYPE=Release \
-DFAISS_OPT_LEVEL=avx2 \
-DFAISS_ENABLE_ROCM=OFF \
-DFAISS_ENABLE_C_API=OFF \
-DOpenMP_CXX_FLAGS="-Xpreprocessor -fopenmp -I${libompInstalledDir}/include" \
-DOpenMP_CXX_LIB_NAMES="omp" \
-DOpenMP_C_FLAGS="-Xpreprocessor -fopenmp -I${libompInstalledDir}/include" \
-DOpenMP_C_LIB_NAMES="omp" \
-DOpenMP_omp_LIBRARY=${libompInstalledDir}/lib/libomp.dylib \
-DPython3_EXECUTABLE=$CONDA_PREFIX/bin/python \
-DPython3_INCLUDE_DIR=$CONDA_PREFIX/include/python$CONDA_PYTHON_VERSION \
-DPython3_LIBRARY=$CONDA_PREFIX/lib/libpython$CONDA_PYTHON_VERSION.dylib \
-DPython_EXECUTABLE=$CONDA_PREFIX/bin/python \
-DPython_INCLUDE_DIR=$CONDA_PREFIX/include/python$CONDA_PYTHON_VERSION \
-DPython_LIBRARY=$CONDA_PREFIX/lib/libpython$CONDA_PYTHON_VERSION.dylib \
-DPython_ROOT_DIR=$CONDA_PREFIX \
-DCMAKE_SHARED_LINKER_FLAGS="-undefined dynamic_lookup" \
-B build .
