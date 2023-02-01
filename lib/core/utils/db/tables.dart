class Tables {
  static const project = """
    Create table project(
      id integer primary key autoincrement not null,
      name text not null,
      description text,
      createdAt timestamp not null
    );
  """;
}
