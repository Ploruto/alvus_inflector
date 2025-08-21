# alvus_inflector

[![Package Version](https://img.shields.io/hexpm/v/alvus_inflector)](https://hex.pm/packages/alvus_inflector)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/alvus_inflector/)

A comprehensive string inflection library for Gleam that handles pluralization, singularization, and various case transformations.

```sh
gleam add alvus_inflector@1
```

## Usage

```gleam
import alvus_inflector/inflector
import gleam/option.{None}

pub fn main() -> Nil {
  // Pluralize words
  inflector.pluralize("person", None) // "people"
  inflector.pluralize("octopus", None) // "octopuses"
  
  // Singularize words
  inflector.singularize("people", None) // "person"
  inflector.singularize("octopuses", None) // "octopus"
  
  // Case transformations
  inflector.camelize("message_properties", False) // "MessageProperties"
  inflector.underscore("MessageProperties", False) // "message_properties"
}
```

## API Reference

### Pluralization & Singularization

#### `pluralize(str: String, plural: Option(String)) -> String`
Converts a word to its plural form. If `plural` is provided, it will be used as the override.

```gleam
inflector.pluralize("person", None)     // "people"
inflector.pluralize("octopus", None)    // "octopuses"
inflector.pluralize("data", None)       // "data" (uncountable)
inflector.pluralize("custom", Some("customs")) // "customs" (override)
```

#### `singularize(str: String, singular: Option(String)) -> String`
Converts a word to its singular form. If `singular` is provided, it will be used as the override.

```gleam
inflector.singularize("people", None)   // "person"
inflector.singularize("octopuses", None) // "octopus"
inflector.singularize("data", None)     // "datum"
inflector.singularize("customs", Some("custom")) // "custom" (override)
```

#### `inflect(str: String, count: Int, singular: Option(String), plural: Option(String)) -> String`
Inflects a word based on count. Uses singular form for count = 1, plural for all other values.

```gleam
inflector.inflect("person", 1, None, None)  // "person"
inflector.inflect("person", 0, None, None)  // "people"
inflector.inflect("person", 2, None, None)  // "people"
```

### Case Transformations

#### `camelize(str: String, first_letter_low: Bool) -> String`
Converts snake_case or kebab-case to camelCase or PascalCase. Handles path separators (`/`) by converting them to module separators (`::`).

```gleam
inflector.camelize("message_properties", False) // "MessageProperties" (PascalCase)
inflector.camelize("message_properties", True)  // "messageProperties" (camelCase)
inflector.camelize("foo/bar_baz", False)        // "Foo::BarBaz"
```

#### `underscore(str: String, all_upper_case: Bool) -> String`
Converts PascalCase/camelCase to snake_case. If `all_upper_case` is `True` and the string is all uppercase, it remains unchanged.

```gleam
inflector.underscore("MessageProperties", False) // "message_properties"
inflector.underscore("messageProperties", False) // "message_properties"
inflector.underscore("MP", True)                 // "MP" (preserved)
inflector.underscore("MP", False)                // "m_p"
```

#### `humanize(str: String, low_first_letter: Bool) -> String`
Converts snake_case to human-readable format by replacing underscores with spaces and optionally capitalizing the first letter. Removes `_id` and `_ids` suffixes.

```gleam
inflector.humanize("message_properties", False) // "Message properties"
inflector.humanize("message_properties", True)  // "message properties"
inflector.humanize("user_id", False)            // "User"
```

#### `capitalize(str: String) -> String`
Capitalizes the first letter of a string and lowercases the rest.

```gleam
inflector.capitalize("message_properties") // "Message_properties"
inflector.capitalize("HELLO WORLD")       // "Hello world"
```

#### `dasherize(str: String) -> String`
Converts spaces and underscores to hyphens.

```gleam
inflector.dasherize("message_properties") // "message-properties"
inflector.dasherize("Message Properties") // "Message-Properties"
```

#### `titleize(str: String) -> String`
Converts a string to title case, capitalizing all words except articles, prepositions, and conjunctions (unless they're the first word).

```gleam
inflector.titleize("message_properties")        // "Message Properties"
inflector.titleize("message properties to keep") // "Message Properties to Keep"
```

### Utility Functions

#### `demodulize(str: String) -> String`
Removes the module path from a string, returning only the last component.

```gleam
inflector.demodulize("Message::Bus::Properties") // "Properties"
inflector.demodulize("SimpleClass")              // "SimpleClass"
```

#### `tableize(str: String) -> String`
Converts a class name to its corresponding table name (underscore + pluralize).

```gleam
inflector.tableize("MessageBusProperty") // "message_bus_properties"
inflector.tableize("Person")            // "people"
```

#### `classify(str: String) -> String`
Converts a table name to its corresponding class name (camelize + singularize).

```gleam
inflector.classify("message_bus_properties") // "MessageBusProperty"
inflector.classify("people")                // "Person"
```

#### `foreign_key(str: String, drop_id_ubar: Bool) -> String`
Creates a foreign key name from a class name. If `drop_id_ubar` is `True`, omits the underscore before "id".

```gleam
inflector.foreign_key("MessageBusProperty", False) // "message_bus_property_id"
inflector.foreign_key("MessageBusProperty", True)  // "message_bus_propertyid"
```

#### `ordinalize(str: String) -> String`
Converts numbers in a string to their ordinal form.

```gleam
inflector.ordinalize("the 1 pitch")  // "the 1st pitch"
inflector.ordinalize("the 22 pitch") // "the 22nd pitch"
inflector.ordinalize("the 23 pitch") // "the 23rd pitch"
```

#### `transform(str: String, transforms: List(TransformFunction)) -> String`
Applies multiple transformations in sequence.

```gleam
import alvus_inflector/inflector.{Pluralize, Dasherize, Capitalize}

inflector.transform("all job", [Pluralize, Dasherize])           // "all-jobs"
inflector.transform("all job", [Capitalize, Pluralize, Dasherize]) // "All-jobs"
```

Available transform functions:
- `Pluralize`
- `Singularize`
- `Camelize`
- `Underscore`
- `Humanize`
- `Capitalize`
- `Dasherize`
- `Titleize`
- `Demodulize`
- `Tableize`
- `Classify`
- `ForeignKey`
- `Ordinalize`

## Uncountable Words

The library includes a comprehensive list of uncountable words (like "data", "information", "sheep") that remain unchanged during pluralization/singularization.

Further documentation can be found at <https://hexdocs.pm/alvus_inflector>.

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```
