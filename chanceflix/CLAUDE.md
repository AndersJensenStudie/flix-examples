# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Context

This is `chanceflix`, a subproject within a bachelor thesis repository (`flixTing`) exploring algebraic effects and effect handlers in the Flix programming language. The broader repo contains ~23 subprojects demonstrating different aspects of Flix's effect system.

## Build & Run

Flix projects require Java and the Flix compiler JAR. There is no system-wide `flix` command; a local compiler JAR exists at `../loggerHandlers/our_flix.jar`.

```bash
# From the project directory (chanceflix/):
java -jar ../loggerHandlers/our_flix.jar run      # Run the project
java -jar ../loggerHandlers/our_flix.jar test      # Run tests
java -jar ../loggerHandlers/our_flix.jar build     # Build
```

**Note:** This project does not yet have a `flix.toml`. Other sibling projects use Flix versions 0.67.1–0.69.2. A `flix.toml` should be created before building (see sibling projects for the format).

## Flix Language Patterns Used in This Repo

- **Effects** are declared with `eff` and define operations: `eff MyEffect { pub def op(x: Int32): Int32 }`
- **Handlers** use `run { ... } with handler EffectName { def operation(k) = ... }` syntax
- **`@DefaultHandler`** annotation marks default handler implementations
- **Effect types** appear in function signatures after `\`: `def main(): Unit \ IO`
- **Stubs** (see `../stubs/`, `../random_stubs/`) replace real effects with fixed values for testing
- **Tests** use `@Test` annotation, returning `Bool` or `Unit \ Assert`

## Sibling Projects (for reference)

Key related subprojects in the parent `flixTing/` directory:
- `handlers`, `ecast`, `algebraic_effects` — core effect handler exploration
- `stubs`, `random_stubs` — stub patterns for testing effects
- `loggerHandlers` — effect handler composition with file I/O
- `translators` — translating between effect types
- `pbt` — property-based testing in Flix
