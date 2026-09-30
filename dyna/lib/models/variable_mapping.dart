import 'engineering_variable.dart';

/// Connects a raw tag found in the file (e.g. "SPDIG") to an
/// engineering variable. If [variable] is null, the tag is not mapped yet.
class VariableMapping {
  final String tag;

  // Not final: the user can change it on the Mapping screen.
  EngineeringVariable? variable;

  VariableMapping({required this.tag, this.variable});

  bool get isMapped => variable != null;
}
