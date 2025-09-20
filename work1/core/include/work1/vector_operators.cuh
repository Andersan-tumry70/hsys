#ifndef HSYS_VECTOR_OPERATORS_CUH
#define HSYS_VECTOR_OPERATORS_CUH

#include "kernels/kernel_vector_add.cuh"
#include "vector.cuh"

#include <cassert>
#include <cudagh.hpp>

namespace hsys {

template <AtomKind AtomT>
Vector<AtomT> operator+(const Vector<AtomT>& lhs, const Vector<AtomT>& rhs) {
  assert(lhs.size() == rhs.size());
  const std::size_t result_size = lhs.size();

  Vector<AtomT> result(result_size);

  kernel_vector_add<<<128, cudagh::cover(result_size, 128)>>>(
      lhs.accessor(), rhs.accessor(), result.accessor());

  // NOTE: ignore Vector::~Vector() (RVO)

  return result;
}

}  // namespace hsys

#endif  // HSYS_VECTOR_OPERATORS_CUH
