import alvus_inflector/inflector
import gleam/option.{None}
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn pluralize_test() {
  inflector.pluralize("accommodation", None)
  |> should.equal("accommodation")

  inflector.pluralize("people", None)
  |> should.equal("people")

  inflector.pluralize("men", None)
  |> should.equal("men")

  inflector.pluralize("women", None)
  |> should.equal("women")

  inflector.pluralize("woman", None)
  |> should.equal("women")

  inflector.pluralize("person", None)
  |> should.equal("people")

  inflector.pluralize("octopus", None)
  |> should.equal("octopuses")

  inflector.pluralize("human", None)
  |> should.equal("humans")

  inflector.pluralize("aircraft", None)
  |> should.equal("aircraft")

  inflector.pluralize("luck", None)
  |> should.equal("luck")

  inflector.pluralize("Hat", None)
  |> should.equal("Hats")

  inflector.pluralize("life", None)
  |> should.equal("lives")

  inflector.pluralize("bath", None)
  |> should.equal("baths")

  inflector.pluralize("calf", None)
  |> should.equal("calves")

  inflector.pluralize("focus", None)
  |> should.equal("focuses")

  inflector.pluralize("foot", None)
  |> should.equal("feet")

  inflector.pluralize("book", None)
  |> should.equal("books")

  inflector.pluralize("goose", None)
  |> should.equal("geese")

  inflector.pluralize("tooth", None)
  |> should.equal("teeth")

  inflector.pluralize("teeth", None)
  |> should.equal("teeth")

  inflector.pluralize("knife", None)
  |> should.equal("knives")

  inflector.pluralize("half", None)
  |> should.equal("halves")

  inflector.pluralize("cave", None)
  |> should.equal("caves")

  inflector.pluralize("save", None)
  |> should.equal("saves")

  inflector.pluralize("street", None)
  |> should.equal("streets")

  inflector.pluralize("streets", None)
  |> should.equal("streets")

  inflector.pluralize("data", None)
  |> should.equal("data")

  inflector.pluralize("meta", None)
  |> should.equal("meta")

  inflector.pluralize("summons", None)
  |> should.equal("summonses")

  inflector.pluralize("whereas", None)
  |> should.equal("whereases")

  inflector.pluralize("index", None)
  |> should.equal("indices")

  inflector.pluralize("matrix", None)
  |> should.equal("matrices")

  inflector.pluralize("vertex", None)
  |> should.equal("vertices")

  inflector.pluralize("canvas", None)
  |> should.equal("canvases")

  inflector.pluralize("campus", None)
  |> should.equal("campuses")

  inflector.pluralize("campuses", None)
  |> should.equal("campuses")

  inflector.pluralize("criterion", None)
  |> should.equal("criteria")

  inflector.pluralize("criteria", None)
  |> should.equal("criteria")

  inflector.pluralize("genus", None)
  |> should.equal("genera")

  inflector.pluralize("genera", None)
  |> should.equal("genera")

  inflector.pluralize("bonus", None)
  |> should.equal("bonuses")

  inflector.pluralize("grammar", None)
  |> should.equal("grammars")

  inflector.pluralize("drive", None)
  |> should.equal("drives")

  inflector.pluralize("database", None)
  |> should.equal("databases")
}

pub fn singularize_test() {
  inflector.singularize("status", None)
  |> should.equal("status")

  inflector.singularize("child", None)
  |> should.equal("child")

  inflector.singularize("children", None)
  |> should.equal("child")

  inflector.singularize("address", None)
  |> should.equal("address")

  inflector.singularize("man", None)
  |> should.equal("man")

  inflector.singularize("woman", None)
  |> should.equal("woman")

  inflector.singularize("women", None)
  |> should.equal("woman")

  inflector.singularize("person", None)
  |> should.equal("person")

  inflector.singularize("people", None)
  |> should.equal("person")

  inflector.singularize("movies", None)
  |> should.equal("movie")

  inflector.singularize("queries", None)
  |> should.equal("query")

  inflector.singularize("octopuses", None)
  |> should.equal("octopus")

  inflector.singularize("Hats", None)
  |> should.equal("Hat")

  inflector.singularize("lives", None)
  |> should.equal("life")

  inflector.singularize("baths", None)
  |> should.equal("bath")

  inflector.singularize("calves", None)
  |> should.equal("calf")

  inflector.singularize("feet", None)
  |> should.equal("foot")

  inflector.singularize("focus", None)
  |> should.equal("focus")

  inflector.singularize("books", None)
  |> should.equal("book")

  inflector.singularize("geese", None)
  |> should.equal("goose")

  inflector.singularize("teeth", None)
  |> should.equal("tooth")

  inflector.singularize("tooth", None)
  |> should.equal("tooth")

  inflector.singularize("knives", None)
  |> should.equal("knife")

  inflector.singularize("halves", None)
  |> should.equal("half")

  inflector.singularize("caves", None)
  |> should.equal("cave")

  inflector.singularize("saves", None)
  |> should.equal("save")

  inflector.singularize("street", None)
  |> should.equal("street")

  inflector.singularize("streets", None)
  |> should.equal("street")

  inflector.singularize("data", None)
  |> should.equal("datum")

  inflector.singularize("meta", None)
  |> should.equal("metum")

  inflector.singularize("whereases", None)
  |> should.equal("whereas")

  inflector.singularize("matrices", None)
  |> should.equal("matrix")

  inflector.singularize("vertices", None)
  |> should.equal("vertex")

  inflector.singularize("canvases", None)
  |> should.equal("canvas")

  inflector.singularize("campuses", None)
  |> should.equal("campus")

  inflector.singularize("campus", None)
  |> should.equal("campus")

  inflector.singularize("criteria", None)
  |> should.equal("criterion")

  inflector.singularize("criterion", None)
  |> should.equal("criterion")

  inflector.singularize("genera", None)
  |> should.equal("genus")

  inflector.singularize("genus", None)
  |> should.equal("genus")

  inflector.singularize("minus", None)
  |> should.equal("minus")

  inflector.singularize("bonuses", None)
  |> should.equal("bonus")

  inflector.singularize("grammars", None)
  |> should.equal("grammar")

  inflector.singularize("drives", None)
  |> should.equal("drive")

  inflector.singularize("databases", None)
  |> should.equal("database")
}

pub fn inflect_test() {
  // zero should use plural state
  inflector.inflect("people", 0, None, None)
  |> should.equal("people")

  inflector.inflect("men", 0, None, None)
  |> should.equal("men")

  inflector.inflect("person", 0, None, None)
  |> should.equal("people")

  inflector.inflect("octopus", 0, None, None)
  |> should.equal("octopuses")

  inflector.inflect("Hat", 0, None, None)
  |> should.equal("Hats")

  inflector.inflect("data", 0, None, None)
  |> should.equal("data")

  inflector.inflect("meta", 0, None, None)
  |> should.equal("meta")

  inflector.inflect("drive", 0, None, None)
  |> should.equal("drives")

  // greater than 1 should use plural state
  inflector.inflect("people", 2, None, None)
  |> should.equal("people")

  inflector.inflect("men", 2, None, None)
  |> should.equal("men")

  inflector.inflect("person", 2, None, None)
  |> should.equal("people")

  inflector.inflect("octopus", 2, None, None)
  |> should.equal("octopuses")

  inflector.inflect("Hat", 2, None, None)
  |> should.equal("Hats")

  inflector.inflect("data", 2, None, None)
  |> should.equal("data")

  inflector.inflect("meta", 2, None, None)
  |> should.equal("meta")

  inflector.inflect("drive", 2, None, None)
  |> should.equal("drives")

  // 1 should use singular state
  inflector.inflect("status", 1, None, None)
  |> should.equal("status")

  inflector.inflect("child", 1, None, None)
  |> should.equal("child")

  inflector.inflect("children", 1, None, None)
  |> should.equal("child")

  inflector.inflect("address", 1, None, None)
  |> should.equal("address")

  inflector.inflect("person", 1, None, None)
  |> should.equal("person")

  inflector.inflect("people", 1, None, None)
  |> should.equal("person")

  inflector.inflect("movies", 1, None, None)
  |> should.equal("movie")

  inflector.inflect("queries", 1, None, None)
  |> should.equal("query")

  inflector.inflect("octopuses", 1, None, None)
  |> should.equal("octopus")

  inflector.inflect("Hats", 1, None, None)
  |> should.equal("Hat")

  inflector.inflect("data", 1, None, None)
  |> should.equal("datum")

  inflector.inflect("meta", 1, None, None)
  |> should.equal("metum")

  inflector.inflect("drive", 1, None, None)
  |> should.equal("drive")

  inflector.inflect("drives", 1, None, None)
  |> should.equal("drive")
}

pub fn camelize_test() {
  inflector.camelize("message_properties", False)
  |> should.equal("MessageProperties")

  inflector.camelize("message_properties", True)
  |> should.equal("messageProperties")

  inflector.camelize("Message_Properties", False)
  |> should.equal("MessageProperties")

  inflector.camelize("Message_Properties", True)
  |> should.equal("messageProperties")

  inflector.camelize("MESSAGE_PROPERTIES", False)
  |> should.equal("MESSAGEProperties")

  inflector.camelize("MESSAGE_PROPERTIES", True)
  |> should.equal("mESSAGEProperties")

  inflector.camelize("fooBar_Baz", True)
  |> should.equal("fooBarBaz")

  inflector.camelize("FooBar_Baz", True)
  |> should.equal("fooBarBaz")

  inflector.camelize("fooBar_fooBaz", True)
  |> should.equal("fooBarFoobaz")

  inflector.camelize("FooBar_FooBaz", True)
  |> should.equal("fooBarFoobaz")

  inflector.camelize("FooBar", False)
  |> should.equal("FooBar")

  inflector.camelize("FooBar", True)
  |> should.equal("fooBar")

  inflector.camelize("Foo/Bar", True)
  |> should.equal("foo::Bar")

  inflector.camelize("Foo/Bar", False)
  |> should.equal("Foo::Bar")
}

pub fn underscore_test() {
  inflector.underscore("MessageProperties", False)
  |> should.equal("message_properties")

  inflector.underscore("messageProperties", False)
  |> should.equal("message_properties")

  inflector.underscore("MP", False)
  |> should.equal("m_p")

  inflector.underscore("MP", True)
  |> should.equal("MP")
}

pub fn humanize_test() {
  inflector.humanize("message_properties", False)
  |> should.equal("Message properties")

  inflector.humanize("message_properties", True)
  |> should.equal("message properties")
}

pub fn capitalize_test() {
  inflector.capitalize("message_properties")
  |> should.equal("Message_properties")

  inflector.capitalize("message properties")
  |> should.equal("Message properties")
}

pub fn dasherize_test() {
  inflector.dasherize("message_properties")
  |> should.equal("message-properties")

  inflector.dasherize("Message Properties")
  |> should.equal("Message-Properties")
}

pub fn titleize_test() {
  inflector.titleize("message_properties")
  |> should.equal("Message Properties")

  inflector.titleize("message properties to keep")
  |> should.equal("Message Properties to Keep")
}

pub fn demodulize_test() {
  inflector.demodulize("Message::Bus::Properties")
  |> should.equal("Properties")
}

pub fn tableize_test() {
  inflector.tableize("people")
  |> should.equal("people")

  inflector.tableize("MessageBusProperty")
  |> should.equal("message_bus_properties")
}

pub fn classify_test() {
  inflector.classify("message_bus_properties")
  |> should.equal("MessageBusProperty")
}

pub fn foreign_key_test() {
  inflector.foreign_key("MessageBusProperty", False)
  |> should.equal("message_bus_property_id")

  inflector.foreign_key("MessageBusProperty", True)
  |> should.equal("message_bus_propertyid")
}

pub fn ordinalize_test() {
  inflector.ordinalize("the 1 pitch")
  |> should.equal("the 1st pitch")

  inflector.ordinalize("the 22 pitch")
  |> should.equal("the 22nd pitch")

  inflector.ordinalize("the 23 pitch")
  |> should.equal("the 23rd pitch")
}

pub fn transform_test() {
  inflector.transform("all job", [inflector.Pluralize, inflector.Dasherize])
  |> should.equal("all-jobs")

  inflector.transform("all job", [inflector.Pluralize])
  |> should.equal("all jobs")

  inflector.transform("all job", [
    inflector.Capitalize,
    inflector.Pluralize,
    inflector.Dasherize,
  ])
  |> should.equal("All-jobs")
}
