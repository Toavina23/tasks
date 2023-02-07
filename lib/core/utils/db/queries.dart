class Queries {
  static const project = """Select
    project.id,
    project.name,
    project.createdAt,
    project.categoryId,
    category.name as categoryName
from
    project
    join category on project.categoryId = category.id""";
}
