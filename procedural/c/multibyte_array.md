# Multibyte Array

If we create an array of structs it gets crazy because we can access and manipulate the elements using either indexing or pointer arithmetic

Let's explore how multi-byte width structures are managed in memory.

- We start with this struct
  ```c
  typedef struct Coordinate {
      int x;
      int y;
      int z;
  } coordinate_t;
  ```
- We can declare an array of 3 `Coordinate` structs
  ```c
  coordinate_t points[3] = {
      {1, 2, 3},
      {4, 5, 6},
      {7, 8, 9},
  };
  ```
- Then we can print out the values of the second element array:
  ```c
  prinf("points[1].x = %d, points[1].y = %d, points[1].z = %d",
       points[1].x, points[1].y, points[1].z);
  ```
- Or we can use a pointer:

  ```c
  coordinate_t *ptr = points;
  prinf("ptr[1].x = %d, ptr[1].y = %d, ptr[1].z = %d",
       *(ptr + 1)->x, *(ptr + 1)->y, *(ptr + 1)->z);
  ```

  ## Memory Layout

  | Address | Element       | Value | Offset(bytes) |
  | ------- | ------------- | ----- | ------------- |
  | 0x2000  | `points[0],x` | 1     | 0             |
  | 0x2004  | `points[0].y` | 2     | 4             |
  | 0x2008  | `points[0].z` | 3     | 8             |
  | 0x200C  | `points[1].x` | 4     | 12            |
  | 0x2010  | `points[1].y` | 5     | 16            |
  | 0x2014  | `points[1].z` | 6     | 20            |

## Accessing Elements Using Pointers

- `points + 0` or `&points[0]` points to 0x2000
- `points + 1` or `&points[1]` points to 0x200C (offset by 12 bytes)
- `points + 2` or `&points[2]` points to 0x2018
