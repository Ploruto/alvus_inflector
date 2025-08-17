import gleam/io
import gleam/option.{None}
import alvus_inflector/inflector

pub fn main() -> Nil {
  io.println("Testing inflector:")
  
  io.println("person -> " <> inflector.pluralize("person", None))
  io.println("people -> " <> inflector.singularize("people", None))
  io.println("message_properties -> " <> inflector.camelize("message_properties", False))
  io.println("MessageProperties -> " <> inflector.underscore("MessageProperties", False))
  io.println("message_properties -> " <> inflector.titleize("message_properties"))
}
