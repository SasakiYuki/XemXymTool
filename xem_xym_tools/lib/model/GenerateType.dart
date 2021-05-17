enum GenerateType { XEM, XYM }

class GenerateTypeHelper {
  static GenerateType getInitialValue() {
    return GenerateType.XEM;
  }

  static GenerateType getGenerateType(int id) =>
      GenerateType.values.firstWhere((element) => element.id == id);
}

extension GenerateTypeExt on GenerateType {
  int get id {
    switch (this) {
      case GenerateType.XEM:
        return 0;
      case GenerateType.XYM:
        return 1;
    }
  }

  String get name {
    switch (this) {
      case GenerateType.XEM:
        return 'XEM';
      case GenerateType.XYM:
        return 'XYM';
    }
  }
}
