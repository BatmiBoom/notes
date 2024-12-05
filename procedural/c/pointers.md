## Pointers

Pointers are just an address (value) that tells the computer where to look for other values. Just like how the address to your house is not actually your house, but points you to where your house is

- Declare a pointer to an integer:
  ```c
  int *pointer_to_something; // declares pointer as a pointer to an int
  ```
- Get the address of a variable
  ```c
  int meaning_of_life = 42;
  int *pointer_to_mol = &meaning_of_life; // holds the address of meaning of life
  ```
- Dereferencing Pointers
  Access to the value not the address that the pointer points to
  ```c
  int meaning_of_life = 42;
  int *pointer_to_mol = &meaning_of_life; // address
  int value_at_pointer = *pointer_to_mol; // 42
  ```

The `*` operator is used for two different things:

- Declaring a pointer type: `int *pointer_to_thing;`
- Dereferencing a pointer value: `*pointer_to_thing = 20;`

## Pointers to Structs

When we're working with a pointer to a struct, you need to use the arrow (`->`) operator:

```c
coordinate_t point = {10, 20, 30};
coordinate_t *ptrToPoint = &point;
prinf("X: %d\n", ptrToPoint->x);
```

It effectively dereferences the pointer and accesses the field in one step. You can also use the dereference and dot operator to achieve the same result:

```c
coordinate_t point = {10, 20, 30};
coordinate_t *ptrToPoint = &point;
printf("X: %d\n", (*ptrToPoint).x);
```

## Order of Operations

The `.` operator has a higher precedence than the `*` operator, so parentheses are necessary when using `*` to dereference a pointer before accessing a member. Which is another reason why the arrow operator is so much more common.

### Why Pointers?

To illustrate the usefulness of pointers, let's pretend we want to pass a collection of data into a function. Within that function, we want to modify the data. In Python, we could use a class to store the data, and pass an instance of that class into the function:

```python
class Coordinate:
    def __init__(self, x, y, z):
        self.x = x
        self.y = y
        self.z = z

def update_coordinate_x(coor, new_x):
    coor.x = new_x

c = Coordinate(1, 2, 3)
print(c.x)  # 1
update_coordinate_x(c, 4)
print(c.x)  # 4
```

- In C, structs are passed by value. If we pass the struct to a function and made an update, the change will only live inside of the function
- To get the change to "persist", we needed to return the updated struct from the function (a new copy).
- The memory address of the struct that went in to coordinate_update_and_return_x was not the same as the address of the struct that was returned. Again, because we created a copy.

```c
//  This doesn't update the struct that was pass as an argument
void coordinate_update_x(coordinate_t coor, int new_x) {
  coor.x = new_x;
}

// This returns a new struct entirely without modifying the existent one
coordinate_t coordinate_update_and_return_x(coordinate_t coor, int new_x) {
  return (coordinate_t){
    .x = new_x,
    .y = coor.y,
    .z = coor.z,
  };
}
```

# Advanced Pointers

- [Pointer Size](./pointer_size.md)
- [Pointer To Pointers](./pointer_pointers.md)
- [Array of Pointers](./array_of_pointers.md)
- [Void Pointers](./void_pointers.md)
- [Swapping](./swapping.md)
