# Enums

C has explicit support for enumerations with the `enum` keyword.

You can define a new enum type like this:

```c
typedef enum DaysOfWeek {
  MONDAY,
  TACO_TUESDAY,
  WEDNESDAY,
  THURSDAY,
  FRIDAY,
  SATURDAY,
  FUNDAY,
} days_of_week_t;
```

The `typedef` and its alias `days_of_week_t` are optional, but like with structs, they make the `enum` easier to use.

In the example above, `days_of_week_t` is a new type that can only have one of the values defined in the `enum`:

- `MONDAY`, which is 0
- `TACO_TUESDAY`, which is 1
- `WEDNESDAY`, which is 2
- `THURSDAY`, which is 3
- `FRIDAY`, which is 4
- `SATURDAY`, which is 5
- `FUNDAY`, which is 6

You can use the `enum` type like this:

```c
typedef struct Event {
    char *title;
    days_of_week_t day;
} event_t;

// Or if you don't want to use the alias:
typedef struct Event {
    char *title;
    enum DaysOfWeek day;
} event_t;
```

An `enum` is not a **collection** type like a struct or an array. It's just a list of integers constrained to a new type, where each is given an explicit name.

## Non-Default Values

Sometimes we want to set those enumerations to specific values. For example, we might want to define a program's _exit status codes_:

```c
typedef enum {
    EXIT_SUCCESS = 0,
    EXIT_FAILURE = 1,
    EXIT_COMMAND_NOT_FOUND = 127,
} ExitStatus;

// Alternatively, you can define the first value and let the compiler fill in the rest (incrementing by 1):

typedef enum {
  LANE_WPM = 200,
  PRIME_WPM, // 201
  TEEJ_WPM,  // 202
} WordsPerMinute;
```

## Sizeof Enum

The same `sizeof` operator that we've talked about works on enums.

- Generally are the same size as an int.
- If value exceeds the range of an int, the C compiler will use a larger integer type to accommodate the value, such as an `unsigned int` or a `long`.

Enums are often used to represent the possibilities in a set. For example:

- `SMALL` = 0
- `MEDIUM` = 1
- `LARGE` = 2
- `EXTRA_LARGE` = 3

Your code probably cares a lot about which size a variable represents, but it probably doesn't care that SMALL happens to be 0 under the hood.

## Switch Case

One of the best features of enums is that it can be used in switch statements. Enums + switch statements:

- Avoid "magic numbers"
- Use descriptive names
- With modern tooling, will give you an error/warning that you haven't handled all the cases in your switch

```c
switch (logLevel) {
  case LOG_DEBUG:
    printf("Debug logging enabled\n");
    break;
  case LOG_INFO:
    printf("Info logging enabled\n");
    break;
  case LOG_WARN:
    printf("Warning logging enabled\n");
    break;
  case LOG_ERROR:
    printf("Error logging enabled\n");
    break;
  default:
    printf("Unknown log level: %d\n", logLevel);
    break;
}
```

You'll notice that we have a `break` after each case. If you do not have a `break`, the next case will still execute: it "falls through" to the next case.

> NEVER FORGET TO PUT BREAK

In some rare cases, you might want the fallthrough:

```c
switch (errorCode) {
  case 1:
  case 2:
  case 3:
    // 1, 2, and 3 are all minor errors
    printf("Minor error occurred. Please try again.\n");
    break;
  case 4:
  case 5:
    // 4 and 5 are major errors
    printf("Major error occurred. Restart required.\n");
    break;
  default:
    printf("Unknown error.\n");
    break;
}
```

But usually, it's a footgun.

We can return from the `enum`

```c
char *http_to_str(HttpErrorCode code) {
  switch(code) {
    case HTTP_BAD_REQUEST:
      return "400 Bad Request";
    case HTTP_UNAUTHORIZED:
      return "401 Unauthorized";
    case HTTP_NOT_FOUND:
      return "404 Not Found";
    case HTTP_TEAPOT:
      return "418 I AM A TEAPOT!";
    case HTTP_INTERNAL_SERVER_ERROR:
      return "500 Internal Server Error";
    default:
      return "Unknown HTTP status code";
  }
}
```

## Memory Layout

Unions store their value in the same memory location, no matter which field or type is actively being used.

That means that accessing any field apart from the one you set is generally a **bad idea**.
