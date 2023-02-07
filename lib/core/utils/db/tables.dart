class Tables {
  static const category = """
    Create table category(
      id integer primary key autoincrement not null,
      name text not null,
    );
  """;
  static const project = """
    Create table project(
      id integer primary key autoincrement not null,
      name text not null,
      createdAt timestamp not null,
      categoryId int not null,
      foreign key (categoryId) references category(id)
    ;
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
