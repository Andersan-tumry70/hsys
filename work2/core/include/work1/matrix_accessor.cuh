#ifndef HSYS_MATRIX_ACCESSOR
#define HSYS_MATRIX_ACCESSOR

#include "kinds.cuh"

namespace hsys {

template <AtomKind AtomT>
struct MatrixAccessor {
  struct hsys_matrix_accessor_feature {};
 public:
  using atom_t = AtomT;

 private:
  atom_t* data_;
  std::size_t nrows_
  std::size_t ncols_;

 public:
  __host__ __device__  MatrixAccessor(atom_t* data, std::size_t nrows, std::size_t ncols)
      : data_(data), nrows_(nrows), ncols_(ncols) {}

   [[nodiscard]] __host__ __device__ std::size_t size() const {
    return nrows_ * ncols_;
  }

  [[nodiscard]] __host__ __device__ std::size_t nrows() const {
    return nrows_;
  }

  [[nodiscard]] __host__ __device__ std::size_t ncols() const {
    return ncols_;
  }

  __host__ __device__ atom_t& operator[](std::size_t i) {
    return data_[i];
  }

  __host__ __device__ const atom_t& operator[](std::size_t i) const {
    return data_[i];
  }

  __host__ __device__ atom_t& operator()(std::size_t i, std::size_t j) {
    return data_[i * ncols_ + j];
  }

  __host__ __device__ const atom_t& operator()(std::size_t i, std::size_t j) const {
    return data_[i * ncols_ + j];
  }

};

}  // namespace hsys

#endif  // HSYS_MATRIX_ACCESSOR
