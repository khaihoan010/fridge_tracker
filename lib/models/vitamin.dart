class Vitamin {
  final String code;
  final String name;
  final String nameVi;
  final String benefits;
  final String benefitsVi;
  final double rdaMale;
  final double rdaFemale;
  final double rdaPregnant;
  final double rdaLactating;
  final String unit;
  final String icon;
  final String color;

  Vitamin({
    required this.code,
    required this.name,
    required this.nameVi,
    required this.benefits,
    required this.benefitsVi,
    required this.rdaMale,
    required this.rdaFemale,
    required this.rdaPregnant,
    required this.rdaLactating,
    required this.unit,
    required this.icon,
    required this.color,
  });

  factory Vitamin.fromMap(Map<String, dynamic> map) {
    return Vitamin(
      code: map['code'] ?? '',
      name: map['name'] ?? '',
      nameVi: map['name_vi'] ?? '',
      benefits: map['benefits'] ?? '',
      benefitsVi: map['benefits_vi'] ?? '',
      rdaMale: (map['rda_male'] ?? 0).toDouble(),
      rdaFemale: (map['rda_female'] ?? 0).toDouble(),
      rdaPregnant: (map['rda_pregnant'] ?? 0).toDouble(),
      rdaLactating: (map['rda_lactating'] ?? 0).toDouble(),
      unit: map['unit'] ?? 'mg',
      icon: map['icon'] ?? '',
      color: map['color'] ?? '#000000',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'name_vi': nameVi,
      'benefits': benefits,
      'benefits_vi': benefitsVi,
      'rda_male': rdaMale,
      'rda_female': rdaFemale,
      'rda_pregnant': rdaPregnant,
      'rda_lactating': rdaLactating,
      'unit': unit,
      'icon': icon,
      'color': color,
    };
  }

  /// Get RDA for specific user profile
  double getRDAForProfile({
    required String gender,
    bool isPregnant = false,
    bool isLactating = false,
  }) {
    if (isLactating) return rdaLactating;
    if (isPregnant) return rdaPregnant;
    if (gender == 'male') return rdaMale;
    return rdaFemale;
  }

  @override
  String toString() {
    return 'Vitamin(code: $code, name: $name, nameVi: $nameVi)';
  }
}
