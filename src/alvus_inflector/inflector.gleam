import gleam/int
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/regexp.{type Regexp}
import gleam/string

pub type Rule {
  Rule(pattern: Regexp, replacement: Option(String))
}

pub const uncountable_words = [
  "accommodation",
  "adulthood",
  "advertising",
  "advice",
  "aggression",
  "aid",
  "air",
  "aircraft",
  "alcohol",
  "anger",
  "applause",
  "arithmetic",
  "assistance",
  "athletics",
  "bacon",
  "baggage",
  "beef",
  "biology",
  "blood",
  "botany",
  "bread",
  "butter",
  "carbon",
  "cardboard",
  "cash",
  "chalk",
  "chaos",
  "chess",
  "crossroads",
  "countryside",
  "dancing",
  "deer",
  "dignity",
  "dirt",
  "dust",
  "economics",
  "education",
  "electricity",
  "engineering",
  "enjoyment",
  "envy",
  "equipment",
  "ethics",
  "evidence",
  "evolution",
  "fame",
  "fiction",
  "flour",
  "flu",
  "food",
  "fuel",
  "fun",
  "furniture",
  "gallows",
  "garbage",
  "garlic",
  "genetics",
  "gold",
  "golf",
  "gossip",
  "gratitude",
  "grief",
  "guilt",
  "gymnastics",
  "happiness",
  "hardware",
  "harm",
  "hate",
  "hatred",
  "health",
  "heat",
  "help",
  "homework",
  "honesty",
  "honey",
  "hospitality",
  "housework",
  "humour",
  "hunger",
  "hydrogen",
  "ice",
  "importance",
  "inflation",
  "information",
  "innocence",
  "iron",
  "irony",
  "jam",
  "jewelry",
  "judo",
  "karate",
  "knowledge",
  "lack",
  "laughter",
  "lava",
  "leather",
  "leisure",
  "lightning",
  "linguine",
  "linguini",
  "linguistics",
  "literature",
  "litter",
  "livestock",
  "logic",
  "loneliness",
  "luck",
  "luggage",
  "macaroni",
  "machinery",
  "magic",
  "management",
  "mankind",
  "marble",
  "mathematics",
  "mayonnaise",
  "measles",
  "methane",
  "milk",
  "minus",
  "money",
  "mud",
  "music",
  "mumps",
  "nature",
  "news",
  "nitrogen",
  "nonsense",
  "nurture",
  "nutrition",
  "obedience",
  "obesity",
  "oxygen",
  "pasta",
  "patience",
  "physics",
  "poetry",
  "pollution",
  "poverty",
  "pride",
  "psychology",
  "publicity",
  "punctuation",
  "quartz",
  "racism",
  "relaxation",
  "reliability",
  "research",
  "respect",
  "revenge",
  "rice",
  "rubbish",
  "rum",
  "safety",
  "scenery",
  "seafood",
  "seaside",
  "series",
  "shame",
  "sheep",
  "shopping",
  "sleep",
  "smoke",
  "smoking",
  "snow",
  "soap",
  "software",
  "soil",
  "spaghetti",
  "species",
  "steam",
  "stuff",
  "stupidity",
  "sunshine",
  "symmetry",
  "tennis",
  "thirst",
  "thunder",
  "timber",
  "traffic",
  "transportation",
  "trust",
  "underwear",
  "unemployment",
  "unity",
  "validity",
  "veal",
  "vegetation",
  "vegetarianism",
  "vengeance",
  "violence",
  "vitality",
  "warmth",
  "wealth",
  "weather",
  "welfare",
  "wheat",
  "wildlife",
  "wisdom",
  "yoga",
  "zinc",
  "zoology",
]

fn compile_regex(pattern: String) -> Result(Regexp, regexp.CompileError) {
  regexp.from_string(pattern)
}

fn apply_rules(
  str: String,
  rules: List(Rule),
  skip: List(String),
  override: Option(String),
) -> String {
  case override {
    Some(override_str) -> override_str
    None -> {
      case list.contains(skip, string.lowercase(str)) {
        True -> str
        False -> apply_rules_inner(str, rules)
      }
    }
  }
}

fn apply_rules_inner(str: String, rules: List(Rule)) -> String {
  case rules {
    [] -> str
    [Rule(pattern, replacement), ..rest] -> {
      case regexp.check(with: pattern, content: str) {
        True -> {
          case replacement {
            Some(repl) -> apply_replacement(pattern, str, repl)
            None -> str
          }
        }
        False -> apply_rules_inner(str, rest)
      }
    }
  }
}

fn apply_replacement(
  pattern: Regexp,
  str: String,
  replacement: String,
) -> String {
  case string.contains(replacement, "$") {
    False -> regexp.replace(each: pattern, in: str, with: replacement)
    True -> {
      regexp.match_map(each: pattern, in: str, with: fn(match) {
        substitute_captures(replacement, match.submatches)
      })
    }
  }
}

fn substitute_captures(
  replacement: String,
  captures: List(Option(String)),
) -> String {
  list.index_fold(captures, replacement, fn(acc, capture, index) {
    let placeholder = "$" <> int.to_string(index + 1)
    case capture {
      Some(value) -> string.replace(acc, placeholder, value)
      None -> acc
    }
  })
}

fn create_plural_rules() -> List(Rule) {
  let assert Ok(men) = compile_regex("^(m|wom)en$")
  let assert Ok(people) = compile_regex("(pe)ople$")
  let assert Ok(children) = compile_regex("(child)ren$")
  let assert Ok(tia) = compile_regex("([ti])a$")
  let assert Ok(analyses) =
    compile_regex(
      "((a)naly|(b)a|(d)iagno|(p)arenthe|(p)rogno|(s)ynop|(t)he)ses$",
    )
  let assert Ok(databases) = compile_regex("(database)s$")
  let assert Ok(drives) = compile_regex("(drive)s$")
  let assert Ok(hives) = compile_regex("(hi|ti)ves$")
  let assert Ok(curves) = compile_regex("(curve)s$")
  let assert Ok(lrves) = compile_regex("([lr])ves$")
  let assert Ok(aves) = compile_regex("([a])ves$")
  let assert Ok(foves) = compile_regex("([^fo])ves$")
  let assert Ok(movies) = compile_regex("(m)ovies$")
  let assert Ok(aeiouyies) = compile_regex("([^aeiouy]|qu)ies$")
  let assert Ok(series) = compile_regex("(s)eries$")
  let assert Ok(xes) = compile_regex("(x|ch|ss|sh)es$")
  let assert Ok(mice) = compile_regex("([m|l])ice$")
  let assert Ok(buses) = compile_regex("(bus)es$")
  let assert Ok(oes) = compile_regex("(o)es$")
  let assert Ok(shoes) = compile_regex("(shoe)s$")
  let assert Ok(crises) = compile_regex("(cris|ax|test)es$")
  let assert Ok(octopuses) = compile_regex("(octop|vir)uses$")
  let assert Ok(aliases) = compile_regex("(alias|canvas|status|campus)es$")
  let assert Ok(summonses) = compile_regex("^(summons|bonus)es$")
  let assert Ok(oxen) = compile_regex("^(ox)en")
  let assert Ok(matrices) = compile_regex("(matr)ices$")
  let assert Ok(vertices) = compile_regex("(vert|ind)ices$")
  let assert Ok(feet) = compile_regex("^feet$")
  let assert Ok(teeth) = compile_regex("^teeth$")
  let assert Ok(geese) = compile_regex("^geese$")
  let assert Ok(quizzes) = compile_regex("(quiz)zes$")
  let assert Ok(whereases) = compile_regex("^(whereas)es$")
  let assert Ok(criteria) = compile_regex("^(criteri)a$")
  let assert Ok(genera) = compile_regex("^genera$")
  let assert Ok(ss) = compile_regex("ss$")
  let assert Ok(s) = compile_regex("s$")

  // Singular patterns for pluralization
  let assert Ok(man) = compile_regex("^(m|wom)an$")
  let assert Ok(person) = compile_regex("(pe)rson$")
  let assert Ok(child) = compile_regex("(child)$")
  let assert Ok(drive) = compile_regex("(drive)$")
  let assert Ok(ox) = compile_regex("^(ox)$")
  let assert Ok(axis) = compile_regex("(ax|test)is$")
  let assert Ok(octopus) = compile_regex("(octop|vir)us$")
  let assert Ok(alias) = compile_regex("(alias|status|canvas|campus)$")
  let assert Ok(summons) = compile_regex("^(summons|bonus)$")
  let assert Ok(bus) = compile_regex("(bu)s$")
  let assert Ok(buffalo) = compile_regex("(buffal|tomat|potat)o$")
  let assert Ok(tium) = compile_regex("([ti])um$")
  let assert Ok(sis) = compile_regex("sis$")
  let assert Ok(fe_ending) = compile_regex("(.*)fe$")
  let assert Ok(lf_ending) = compile_regex("(.*)lf$")
  let assert Ok(rf_ending) = compile_regex("(.*)rf$")
  let assert Ok(focus) = compile_regex("^(focus)$")
  let assert Ok(hive) = compile_regex("(hi|ti)ve$")
  let assert Ok(aeiouyy) = compile_regex("([^aeiouy]|qu)y$")
  let assert Ok(x) = compile_regex("(x|ch|ss|sh)$")
  let assert Ok(matrix) = compile_regex("(matr)ix$")
  let assert Ok(vertex) = compile_regex("(vert|ind)ex$")
  let assert Ok(mouse) = compile_regex("([m|l])ouse$")
  let assert Ok(foot) = compile_regex("^foot$")
  let assert Ok(tooth) = compile_regex("^tooth$")
  let assert Ok(goose) = compile_regex("^goose$")
  let assert Ok(quiz) = compile_regex("(quiz)$")
  let assert Ok(whereas) = compile_regex("^(whereas)$")
  let assert Ok(criterion) = compile_regex("^(criteri)on$")
  let assert Ok(genus) = compile_regex("^genus$")
  let assert Ok(common) = compile_regex("$")

  [
    // Do not replace if already plural
    Rule(men, None),
    Rule(people, None),
    Rule(children, None),
    Rule(tia, None),
    Rule(analyses, None),
    Rule(databases, None),
    Rule(drives, None),
    Rule(hives, None),
    Rule(curves, None),
    Rule(lrves, None),
    Rule(foves, None),
    Rule(aeiouyies, None),
    Rule(series, None),
    Rule(movies, None),
    Rule(xes, None),
    Rule(mice, None),
    Rule(buses, None),
    Rule(oes, None),
    Rule(shoes, None),
    Rule(crises, None),
    Rule(octopuses, None),
    Rule(aliases, None),
    Rule(summonses, None),
    Rule(oxen, None),
    Rule(matrices, None),
    Rule(feet, None),
    Rule(teeth, None),
    Rule(geese, None),
    Rule(quizzes, None),
    Rule(whereases, None),
    Rule(criteria, None),
    Rule(genera, None),

    // Pluralization rules
    Rule(man, Some("$1en")),
    Rule(person, Some("$1ople")),
    Rule(child, Some("$1ren")),
    Rule(drive, Some("$1s")),
    Rule(ox, Some("$1en")),
    Rule(axis, Some("$1es")),
    Rule(octopus, Some("$1uses")),
    Rule(alias, Some("$1es")),
    Rule(summons, Some("$1es")),
    Rule(bus, Some("$1ses")),
    Rule(buffalo, Some("$1oes")),
    Rule(tium, Some("$1a")),
    Rule(sis, Some("ses")),
    Rule(fe_ending, Some("$1ves")),
    Rule(lf_ending, Some("$1ves")),
    Rule(rf_ending, Some("$1ves")),
    Rule(focus, Some("$1es")),
    Rule(hive, Some("$1ves")),
    Rule(aeiouyy, Some("$1ies")),
    Rule(matrix, Some("$1ices")),
    Rule(vertex, Some("$1ices")),
    Rule(x, Some("$1es")),
    Rule(mouse, Some("$1ice")),
    Rule(foot, Some("feet")),
    Rule(tooth, Some("teeth")),
    Rule(goose, Some("geese")),
    Rule(quiz, Some("$1zes")),
    Rule(whereas, Some("$1es")),
    Rule(criterion, Some("$1a")),
    Rule(genus, Some("genera")),
    Rule(s, Some("s")),
    Rule(common, Some("s")),
  ]
}

fn create_singular_rules() -> List(Rule) {
  let assert Ok(men) = compile_regex("^(m|wom)en$")
  let assert Ok(people) = compile_regex("(pe)ople$")
  let assert Ok(children) = compile_regex("(child)ren$")
  let assert Ok(tia) = compile_regex("([ti])a$")
  let assert Ok(analyses) =
    compile_regex(
      "((a)naly|(b)a|(d)iagno|(p)arenthe|(p)rogno|(s)ynop|(t)he)ses$",
    )
  let assert Ok(databases) = compile_regex("(database)s$")
  let assert Ok(drives) = compile_regex("(drive)s$")
  let assert Ok(hives) = compile_regex("(hi|ti)ves$")
  let assert Ok(curves) = compile_regex("(curve)s$")
  let assert Ok(lrves) = compile_regex("([lr])ves$")
  let assert Ok(aves) = compile_regex("([a])ves$")
  let assert Ok(foves) = compile_regex("([^fo])ves$")
  let assert Ok(movies) = compile_regex("(m)ovies$")
  let assert Ok(aeiouyies) = compile_regex("([^aeiouy]|qu)ies$")
  let assert Ok(series) = compile_regex("(s)eries$")
  let assert Ok(xes) = compile_regex("(x|ch|ss|sh)es$")
  let assert Ok(mice) = compile_regex("([m|l])ice$")
  let assert Ok(buses) = compile_regex("(bus)es$")
  let assert Ok(oes) = compile_regex("(o)es$")
  let assert Ok(shoes) = compile_regex("(shoe)s$")
  let assert Ok(crises) = compile_regex("(cris|ax|test)es$")
  let assert Ok(octopuses) = compile_regex("(octop|vir)uses$")
  let assert Ok(aliases) = compile_regex("(alias|canvas|status|campus)es$")
  let assert Ok(summonses) = compile_regex("^(summons|bonus)es$")
  let assert Ok(oxen) = compile_regex("^(ox)en")
  let assert Ok(matrices) = compile_regex("(matr)ices$")
  let assert Ok(vertices) = compile_regex("(vert|ind)ices$")
  let assert Ok(feet) = compile_regex("^feet$")
  let assert Ok(teeth) = compile_regex("^teeth$")
  let assert Ok(geese) = compile_regex("^geese$")
  let assert Ok(quizzes) = compile_regex("(quiz)zes$")
  let assert Ok(whereases) = compile_regex("^(whereas)es$")
  let assert Ok(criteria) = compile_regex("^(criteri)a$")
  let assert Ok(genera) = compile_regex("^genera$")
  let assert Ok(ss) = compile_regex("ss$")
  let assert Ok(s) = compile_regex("s$")

  // Singular patterns 
  let assert Ok(man) = compile_regex("^(m|wom)an$")
  let assert Ok(person) = compile_regex("(pe)rson$")
  let assert Ok(child) = compile_regex("(child)$")
  let assert Ok(drive) = compile_regex("(drive)$")
  let assert Ok(ox) = compile_regex("^(ox)$")
  let assert Ok(axis) = compile_regex("(ax|test)is$")
  let assert Ok(octopus) = compile_regex("(octop|vir)us$")
  let assert Ok(alias) = compile_regex("(alias|status|canvas|campus)$")
  let assert Ok(summons) = compile_regex("^(summons|bonus)$")
  let assert Ok(bus) = compile_regex("(bu)s$")
  let assert Ok(buffalo) = compile_regex("(buffal|tomat|potat)o$")
  let assert Ok(tium) = compile_regex("([ti])um$")
  let assert Ok(sis) = compile_regex("sis$")
  let assert Ok(fe_ending_s) = compile_regex("(.*)fe$")
  let assert Ok(lf_ending_s) = compile_regex("(.*)lf$")
  let assert Ok(rf_ending_s) = compile_regex("(.*)rf$")
  let assert Ok(focus) = compile_regex("^(focus)$")
  let assert Ok(hive) = compile_regex("(hi|ti)ve$")
  let assert Ok(aeiouyy) = compile_regex("([^aeiouy]|qu)y$")
  let assert Ok(x) = compile_regex("(x|ch|ss|sh)$")
  let assert Ok(matrix) = compile_regex("(matr)ix$")
  let assert Ok(mouse) = compile_regex("([m|l])ouse$")
  let assert Ok(foot) = compile_regex("^foot$")
  let assert Ok(tooth) = compile_regex("^tooth$")
  let assert Ok(goose) = compile_regex("^goose$")
  let assert Ok(quiz) = compile_regex("(quiz)$")
  let assert Ok(whereas) = compile_regex("^(whereas)$")
  let assert Ok(criterion) = compile_regex("^(criteri)on$")
  let assert Ok(genus) = compile_regex("^genus$")

  [
    // Do not replace if already singular
    Rule(man, None),
    Rule(person, None),
    Rule(child, None),
    Rule(drive, None),
    Rule(ox, None),
    Rule(axis, None),
    Rule(octopus, None),
    Rule(alias, None),
    Rule(summons, None),
    Rule(bus, None),
    Rule(buffalo, None),
    Rule(tium, None),
    Rule(sis, None),
    Rule(fe_ending_s, None),
    Rule(lf_ending_s, None),
    Rule(rf_ending_s, None),
    Rule(focus, None),
    Rule(hive, None),
    Rule(aeiouyy, None),
    Rule(x, None),
    Rule(matrix, None),
    Rule(mouse, None),
    Rule(foot, None),
    Rule(tooth, None),
    Rule(goose, None),
    Rule(quiz, None),
    Rule(whereas, None),
    Rule(criterion, None),
    Rule(genus, None),

    // Singularization rules
    Rule(men, Some("$1an")),
    Rule(people, Some("$1rson")),
    Rule(children, Some("$1")),
    Rule(databases, Some("$1")),
    Rule(drives, Some("$1")),
    Rule(genera, Some("genus")),
    Rule(criteria, Some("$1on")),
    Rule(tia, Some("$1um")),
    Rule(analyses, Some("$1$2sis")),
    Rule(hives, Some("$1ve")),
    Rule(curves, Some("$1")),
    Rule(lrves, Some("$1f")),
    Rule(aves, Some("$1ve")),
    Rule(foves, Some("$1fe")),
    Rule(movies, Some("$1ovie")),
    Rule(aeiouyies, Some("$1y")),
    Rule(series, Some("$1eries")),
    Rule(xes, Some("$1")),
    Rule(mice, Some("$1ouse")),
    Rule(buses, Some("$1")),
    Rule(oes, Some("$1")),
    Rule(shoes, Some("$1")),
    Rule(crises, Some("$1is")),
    Rule(octopuses, Some("$1us")),
    Rule(aliases, Some("$1")),
    Rule(summonses, Some("$1")),
    Rule(oxen, Some("$1")),
    Rule(matrices, Some("$1ix")),
    Rule(vertices, Some("$1ex")),
    Rule(feet, Some("foot")),
    Rule(teeth, Some("tooth")),
    Rule(geese, Some("goose")),
    Rule(quizzes, Some("$1")),
    Rule(whereases, Some("$1")),
    Rule(ss, Some("ss")),
    Rule(s, Some("")),
  ]
}

pub fn pluralize(str: String, plural: Option(String)) -> String {
  apply_rules(str, create_plural_rules(), uncountable_words, plural)
}

pub fn singularize(str: String, singular: Option(String)) -> String {
  apply_rules(str, create_singular_rules(), uncountable_words, singular)
}

pub fn inflect(
  str: String,
  count: Int,
  singular: Option(String),
  plural: Option(String),
) -> String {
  case count {
    1 -> apply_rules(str, create_singular_rules(), uncountable_words, singular)
    _ -> apply_rules(str, create_plural_rules(), uncountable_words, plural)
  }
}

pub fn camelize(
  str str: String,
  first_letter_low low_first_letter: Bool,
) -> String {
  let str_path = string.split(str, "/")
  let result =
    list.map(str_path, fn(path_part) {
      let str_arr = string.split(path_part, "_")
      let result =
        list.index_map(str_arr, fn(part, index) {
          let capitalized = capitalize_first_char(part)
          case index == 0 && low_first_letter {
            True ->
              case string.first(capitalized) {
                Ok(first_char) -> {
                  let rest = string.drop_start(capitalized, 1)
                  string.lowercase(first_char) <> rest
                }
                Error(_) -> capitalized
              }
            False -> capitalized
          }
        })
      string.join(result, "")
    })
  string.join(result, "::")
}

fn capitalize_first_char(str: String) -> String {
  case string.first(str) {
    Ok(first_char) -> {
      let rest = string.drop_start(str, 1)
      string.uppercase(first_char) <> rest
    }
    Error(_) -> str
  }
}

pub fn underscore(str: String, all_upper_case: Bool) -> String {
  case all_upper_case && str == string.uppercase(str) {
    True -> str
    False -> {
      let str_path = string.split(str, "::")
      let result =
        list.map(str_path, fn(part) {
          let assert Ok(uppercase_re) = compile_regex("([A-Z])")
          let assert Ok(underbar_prefix_re) = compile_regex("^_")

          let with_underscores =
            regexp.match_map(each: uppercase_re, in: part, with: fn(match) {
              "_" <> string.lowercase(match.content)
            })
          let cleaned =
            regexp.replace(
              each: underbar_prefix_re,
              in: with_underscores,
              with: "",
            )
          string.lowercase(cleaned)
        })
      string.join(result, "/")
    }
  }
}

pub fn humanize(str: String, low_first_letter: Bool) -> String {
  let assert Ok(id_suffix_re) = compile_regex("(_ids|_id)$")
  let assert Ok(underbar_re) = compile_regex("_")

  let str = string.lowercase(str)
  let str = regexp.replace(each: id_suffix_re, in: str, with: "")
  let str = regexp.replace(each: underbar_re, in: str, with: " ")

  case low_first_letter {
    True -> str
    False -> capitalize(str)
  }
}

pub fn capitalize(str: String) -> String {
  let str = string.lowercase(str)
  case string.first(str) {
    Ok(first_char) -> {
      let rest = string.drop_start(str, 1)
      string.uppercase(first_char) <> rest
    }
    Error(_) -> str
  }
}

pub fn dasherize(str: String) -> String {
  let assert Ok(space_or_underbar_re) = compile_regex("[ _]")
  regexp.replace(each: space_or_underbar_re, in: str, with: "-")
}

pub const non_titlecased_words = [
  "and",
  "or",
  "nor",
  "a",
  "an",
  "the",
  "so",
  "but",
  "to",
  "of",
  "at",
  "by",
  "from",
  "into",
  "on",
  "onto",
  "off",
  "out",
  "in",
  "over",
  "with",
  "for",
]

pub fn titleize(str: String) -> String {
  let assert Ok(underbar_re) = compile_regex("_")
  let str =
    string.lowercase(str) |> regexp.replace(each: underbar_re, with: " ")
  let str_arr = string.split(str, " ")

  let result =
    list.index_map(str_arr, fn(word, index) {
      let d = string.split(word, "-")
      let processed =
        list.map(d, fn(part) {
          case index == 0 {
            True -> capitalize(part)
            // Always capitalize first word
            False ->
              case list.contains(non_titlecased_words, string.lowercase(part)) {
                True -> part
                False -> capitalize(part)
              }
          }
        })
      string.join(processed, "-")
    })

  string.join(result, " ")
}

pub fn demodulize(str: String) -> String {
  let str_arr = string.split(str, "::")
  case list.last(str_arr) {
    Ok(last) -> last
    Error(_) -> str
  }
}

pub fn tableize(str: String) -> String {
  str
  |> underscore(False)
  |> pluralize(None)
}

pub fn classify(str: String) -> String {
  str
  |> camelize(False)
  |> singularize(None)
}

pub fn foreign_key(str: String, drop_id_ubar: Bool) -> String {
  let str = demodulize(str)
  let str = underscore(str, False)
  case drop_id_ubar {
    True -> str <> "id"
    False -> str <> "_id"
  }
}

pub fn ordinalize(str: String) -> String {
  let str_arr = string.split(str, " ")
  let result =
    list.map(str_arr, fn(word) {
      case int.parse(word) {
        Ok(k) -> {
          let word_str = int.to_string(k)
          let ltd = case string.length(word_str) >= 2 {
            True -> string.slice(word_str, string.length(word_str) - 2, 2)
            False -> ""
          }
          let ld = string.slice(word_str, string.length(word_str) - 1, 1)

          let suf = case ltd != "11" && ltd != "12" && ltd != "13" {
            True ->
              case ld {
                "1" -> "st"
                "2" -> "nd"
                "3" -> "rd"
                _ -> "th"
              }
            False -> "th"
          }

          word <> suf
        }
        Error(_) -> word
      }
    })
  string.join(result, " ")
}

pub type TransformFunction {
  Pluralize
  Singularize
  Camelize
  Underscore
  Humanize
  Capitalize
  Dasherize
  Titleize
  Demodulize
  Tableize
  Classify
  ForeignKey
  Ordinalize
}

pub fn transform(str: String, transforms: List(TransformFunction)) -> String {
  list.fold(transforms, str, fn(acc_str, transform_fn) {
    case transform_fn {
      Pluralize -> pluralize(acc_str, None)
      Singularize -> singularize(acc_str, None)
      Camelize -> camelize(acc_str, False)
      Underscore -> underscore(acc_str, False)
      Humanize -> humanize(acc_str, False)
      Capitalize -> capitalize(acc_str)
      Dasherize -> dasherize(acc_str)
      Titleize -> titleize(acc_str)
      Demodulize -> demodulize(acc_str)
      Tableize -> tableize(acc_str)
      Classify -> classify(acc_str)
      ForeignKey -> foreign_key(acc_str, False)
      Ordinalize -> ordinalize(acc_str)
    }
  })
}
