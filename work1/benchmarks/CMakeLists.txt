cmake_minimum_required(VERSION 3.31)
project(work1_benchmarks LANGUAGES CXX CUDA)

include(../../cmake/deps/gbench.cmake)
include(../../cmake/deps/eigen.cmake)

find_package(CUDAToolkit REQUIRED)

file(GLOB_RECURSE SRC
    ${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp
)

add_executable(work1_benchmarks ${SRC})

target_compile_features(work1_benchmarks PRIVATE
    cxx_std_20
    cuda_std_20
)

target_compile_options(work1_benchmarks PRIVATE
    -Wall -O3
)

target_link_libraries(work1_benchmarks PRIVATE
    benchmark::benchmark
    Eigen3::Eigen
    work1::core
    work1::cuda_timer
    CUDA::cudart
)
