import 'package:equatable/equatable.dart';
import 'package:tasks/domain/entities/category_entity.dart';

class CategoryModel extends Equatable {
  final int id;
  final String? name;
  const CategoryModel(this.id, this.name);

  factory CategoryModel.fromJson(Map<String, dynamic> data) {
    return CategoryModel(data["id"], data["name"]);
  }

  factory CategoryModel.fromEntity(CategoryEntity entity) {
    return CategoryModel(entity.id, entity.name);
  }

  CategoryEntity toEntity() {
    return CategoryEntity(id, name);
  }

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name};
  }

  @override
  List<Object?> get props => [id, name];
}
