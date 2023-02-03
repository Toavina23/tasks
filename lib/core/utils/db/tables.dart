class Tables {
  static const project = """
    Create table project(
      id integer primary key autoincrement not null,
      name text not null,
      description text,
      createdAt timestamp not null
    );
  """;
  static const tasks = """
    Create table task(
      id integer primary key autoincrement not null,
      name text not null,
      createdAt timestamp not null,
      status int not null default 0,
      difficultyLevel int default 1,
      executionTime int, 
      parentTaskId integer,
      projectId integer,
      foreign key (parentTaskId) references task(id),
      foreign key (projectId) references project(id),
    )
  """;
}
