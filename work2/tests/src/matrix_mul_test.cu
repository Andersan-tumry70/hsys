#include <work2/matrix.cuh>
#include <work2/matrix_operators.cuh>

#define EIGEN_NO_CUDA

#include <Eigen/Dense>
#include <cuda_runtime.h>
#include <cuda_runtime_api.h>
#include <gtest/gtest.h>

using RowMatrixXf = Eigen::Matrix<float, Eigen::Dynamic, Eigen::Dynamic, Eigen::RowMajor>;

class MatrixMulTest : public ::testing::TestWithParam<std::pair<std::size_t, float>> {
 protected:
  bool mmul_test_impl(std::size_t N, float tol) {
    RowMatrixXf A_target = RowMatrixXf::Random(N, N);
    RowMatrixXf B_target = RowMatrixXf::Random(N, N);
    RowMatrixXf C_target = A_target * B_target;

    auto a = hsys::Matrix<float>(N, N);
    a.block().copy_from_host(a_target.data());

    auto b = hsys::Matrix<float>(N, N);
    b.block().copy_from_host(b_target.data());

    auto c = a * b;

    if (C.nrows() != N || C.ncols() != N) {
      return false;
    }

    RowMatrixXf C_from_device(N, N);
    C.block().copy_to_host(C_from_device.data());

    return c_target.isApprox(c_from_device, tol);
  }
};

TEST_P(MatrixMulTest, mmul_test) {
  auto [N, tol] = GetParam();
  EXPECT_TRUE(mmul_test_impl(N, tol));
}

// clang-format off
// INSTANTIATE_TEST_SUITE_P(
//     VectorAddTestSuite,
//     VectorAddTest,
//     ::testing::Values(
//         std::make_pair(1, 1e-6),
//         std::make_pair(2, 1e-6),
//         std::make_pair(3, 1e-6),
//         std::make_pair(127, 1e-6),
//         std::make_pair(128, 1e-6),
//         std::make_pair(129, 1e-6),
//         std::make_pair(512, 1e-6),
//         std::make_pair(513, 1e-6),
//         std::make_pair(1023, 1e-6),
//         std::make_pair(1024, 1e-6)
//     )
// );
// // clang-format on
INSTANTIATE_TEST_SUITE_P(
    MatrixMulTestSuite,
    MatrixMulTest,
    ::testing::Values(
        std::make_pair(1U, 1e-5f),
        std::make_pair(2U, 1e-5f),
        std::make_pair(3U, 1e-5f),
        std::make_pair(15U, 1e-5f),
        std::make_pair(16U, 1e-5f),
        std::make_pair(17U, 1e-5f),
        std::make_pair(31U, 1e-5f),
        std::make_pair(32U, 1e-5f),
        std::make_pair(64U, 1e-4f), 
        std::make_pair(128U, 1e-3f)
    )
);