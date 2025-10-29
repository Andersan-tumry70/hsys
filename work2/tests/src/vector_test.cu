#include <work2/matrix.cuh>

#include <gtest/gtest.h>

/* AI generated code: begin */

using namespace hsys;

TEST(MatrixTest, ConstructorAndSize) {
  const std::size_t nrows = 10;
  const std::size_t ncols = 20;
  Matrix<float> mat(nrows, ncols);

  EXPECT_EQ(mat.nrows(), nrows);
  EXPECT_EQ(mat.ncols(), ncols);
  EXPECT_EQ(mat.size(), nrows * ncols);
}

TEST(MatrixTest, ZeroSizeConstructors) {
  // 0×0
  Matrix<double> mat00(0, 0);
  EXPECT_EQ(mat00.nrows(), 0);
  EXPECT_EQ(mat00.ncols(), 0);
  EXPECT_EQ(mat00.size(), 0);

  // 0×5
  Matrix<int> mat05(0, 5);
  EXPECT_EQ(mat05.nrows(), 0);
  EXPECT_EQ(mat05.ncols(), 5);
  EXPECT_EQ(mat05.size(), 0);

  // 7×0
  Matrix<float> mat70(7, 0);
  EXPECT_EQ(mat70.nrows(), 7);
  EXPECT_EQ(mat70.ncols(), 0);
  EXPECT_EQ(mat70.size(), 0);
}

TEST(MatrixTest, BlockAccess) {
  const std::size_t nrows = 6;
  const std::size_t ncols = 8;
  Matrix<int> mat(nrows, ncols);

  auto block = mat.block();
  EXPECT_EQ(block.size(), nrows * ncols);

  const auto& const_mat = mat;
  auto const_block = const_mat.block();
  EXPECT_EQ(const_block.size(), nrows * ncols);
}

TEST(MatrixTest, AccessorAccess) {
  const std::size_t nrows = 5;
  const std::size_t ncols = 9;
  Matrix<float> mat(nrows, ncols);

  auto accessor = mat.accessor();
  EXPECT_EQ(accessor.nrows(), nrows);
  EXPECT_EQ(accessor.ncols(), ncols);
  EXPECT_EQ(accessor.size(), nrows * ncols);

  const auto& const_mat = mat;
  auto const_accessor = const_mat.accessor();
  EXPECT_EQ(const_accessor.nrows(), nrows);
  EXPECT_EQ(const_accessor.ncols(), ncols);
  EXPECT_EQ(const_accessor.size(), nrows * ncols);
}

TEST(MatrixTest, AccessorDataConsistency) {
  const std::size_t nrows = 4;
  const std::size_t ncols = 7;
  Matrix<double> mat(nrows, ncols);

  auto accessor = mat.accessor();
  auto block = mat.block();

  EXPECT_EQ(accessor.size(), block.size());
  EXPECT_EQ(accessor.nrows(), nrows);
  EXPECT_EQ(accessor.ncols(), ncols);
}

TEST(MatrixTest, DifferentAtomTypes) {
  const std::size_t nrows = 3;
  const std::size_t ncols = 5;

  Matrix<float> float_mat(nrows, ncols);
  Matrix<double> double_mat(nrows, ncols);
  Matrix<int> int_mat(nrows, ncols);

  EXPECT_EQ(float_mat.nrows(), nrows);
  EXPECT_EQ(float_mat.ncols(), ncols);

  EXPECT_EQ(double_mat.nrows(), nrows);
  EXPECT_EQ(double_mat.ncols(), ncols);

  EXPECT_EQ(int_mat.nrows(), nrows);
  EXPECT_EQ(int_mat.ncols(), ncols);
}

TEST(MatrixTest, ConstCorrectness) {
  const std::size_t nrows = 8;
  const std::size_t ncols = 12;
  const Matrix<float> const_mat(nrows, ncols);

  [[maybe_unused]] auto size = const_mat.size();
  [[maybe_unused]] auto nrows_val = const_mat.nrows();
  [[maybe_unused]] auto ncols_val = const_mat.ncols();
  [[maybe_unused]] auto block = const_mat.block();
  [[maybe_unused]] auto accessor = const_mat.accessor();

  EXPECT_EQ(size, nrows * ncols);
  EXPECT_EQ(nrows_val, nrows);
  EXPECT_EQ(ncols_val, ncols);
}

TEST(MatrixTest, InstanceIndependence) {
  Matrix<float> mat1(2, 3);
  Matrix<float> mat2(5, 7);

  EXPECT_EQ(mat1.nrows(), 2);
  EXPECT_EQ(mat1.ncols(), 3);
  EXPECT_EQ(mat2.nrows(), 5);
  EXPECT_EQ(mat2.ncols(), 7);
  EXPECT_NE(mat1.size(), mat2.size());
}

class MatrixSizeTest : public ::testing::TestWithParam<std::pair<std::size_t, std::size_t>> {};

TEST_P(MatrixSizeTest, SizeParameterized) {
  const auto [nrows, ncols] = GetParam();
  Matrix<int> mat(nrows, ncols);

  EXPECT_EQ(mat.nrows(), nrows);
  EXPECT_EQ(mat.ncols(), ncols);
  EXPECT_EQ(mat.size(), nrows * ncols);
}

INSTANTIATE_TEST_SUITE_P(
    MatrixSizes,
    MatrixSizeTest,
    ::testing::Values(
        std::make_pair(0, 0),
        std::make_pair(1, 1),
        std::make_pair(0, 10),
        std::make_pair(10, 0),
        std::make_pair(1, 100),
        std::make_pair(100, 1),
        std::make_pair(32, 32),
        std::make_pair(128, 64)
    )
);

TEST(MatrixTest, FeatureTypeExists) {
  [[maybe_unused]] Matrix<float>::hsys_matrix_accessor_feature feature;
  SUCCEED();
}

/* AI generated code: end */
