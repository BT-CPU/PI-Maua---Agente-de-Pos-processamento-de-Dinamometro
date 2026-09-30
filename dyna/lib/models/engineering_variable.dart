/// A variable that engineers understand (e.g. "Engine Speed" in "rpm").
/// Each raw tag from the file (SPDIG, TORQ...) is mapped to one of these.
class EngineeringVariable {
  final String name;
  final String unit;

  const EngineeringVariable({required this.name, required this.unit});
}
