#include <cudagh.hpp>
//#include <../../Core/
//#include <work2/kernels/kernel_vector_add.cuh>
#include <work2/kernels/kernel_vector_add.cuh>
#include <work2/matrix.cuh>

#define EIGEN_NO_CUDA
#include <Eigen/Dense>
#include <benchmark/benchmark.h>
#include <cuda_timer.hpp>

static void BM_EigenMatrixMulCPU(benchmark::State& state) {
  auto len = state.range(0);

  Eigen::MatrixXf A = Eigen::MatrixXf::Random(N, N);
  Eigen::MatrixXf B = Eigen::MatrixXf::Random(N, N);
  Eigen::MatrixXf C(N, N);

  for (auto _ : state) {
    c = a * b; 
    benchmark::DoNotOptimize(c.data());
    benchmark::ClobberMemory();
  }
}

static void BM_OurMatrixMulGPU(benchmark::State& state) {
  auto N = state.range(0);

  auto a = hsys::Matrix<float>(N, N);
  auto b = hsys::Matrix<float>(N, N);
  auto c = hsys::Matrix<float>(N, N);

  for (auto _ : state) {
    float elapsed_time = 0;
    {
      CUDATimer timer(elapsed_time);
      hsys::kernel_matrix_mul<<<cudagh::cover(size, 128), 128>>>( //TODO: Подумать, стоит ли убирать, <<<...>>>
          c.accessor(), a.accessor(), b.accessor());
    }

    benchmark::DoNotOptimize(elapsed_time);
    benchmark::ClobberMemory();

    state.SetIterationTime(elapsed_time);
  }
}

constexpr const int multiplier = 8;
constexpr const auto range = std::make_pair(8, 1 << 26);
constexpr const auto unit = benchmark::kMillisecond;

BENCHMARK(BM_EigenVectorAddCPU)
    ->Name("Eigen Vector Addition (CPU)")
    ->RangeMultiplier(multiplier)
    ->Ranges({range})
    ->Unit(unit)
    ->UseRealTime()
    ->MeasureProcessCPUTime();

BENCHMARK(BM_OurVectorAddGPU)
    ->Name("CUDA Vector Addition (GPU)")
    ->RangeMultiplier(multiplier)
    ->Ranges({range})
    ->Unit(unit)
    ->UseManualTime();

BENCHMARK_MAIN();  // NOLINT
