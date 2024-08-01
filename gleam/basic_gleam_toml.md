# gleam.toml

```toml
name = "Game of life"
version = "1.0.0"

description = "Basic Conway's Game of Life implemented on Gleam"
licences = ["Apache-2.0"]
repository = { type = "github", user = "BatmiBoom", repo = "GameOfLife" }

target = "erlang"

internal_modules = ["my_app/internal", "my_app/internal/*"]

[dependencies]
gleam_stdlib = ">= 0.34.0 and < 2.0.0"

[dev-dependencies]
gleeunit = ">= 1.0.0 and < 2.0.0"
```
