class FlowCardModel {
  final String id;
  final String title;
  final String category;
  final DateTime? expiration;
  final int participants;
  final String stage;
  final String description;

  const FlowCardModel({
    required this.id,
    required this.title,
    required this.category,
    this.expiration,
    required this.participants,
    required this.stage,
    required this.description,
  });
}
