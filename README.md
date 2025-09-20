# hsys

## Build

### Ninja
```
cmake -B build/ -G Ninja -DCMAKE_BUILD_TYPE=Release
cmake --build build/
```

### Make
```
cmake -B build/ -DCMAKE_BUILD_TYPE=Release
cmake --build build/ -j8
```

## Tests

```
ctest --test-dir build/work1/tests/
```
