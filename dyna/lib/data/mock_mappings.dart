import '../models/engineering_variable.dart';
import '../models/variable_mapping.dart';

// Fake data just to build the UI.
// Later the tags will come from the imported files and the variables
// from the Reference Table.

const _engineSpeed = EngineeringVariable(name: 'Engine Speed', unit: 'rpm');
const _torque = EngineeringVariable(name: 'Torque', unit: 'Nm');
const _bmep = EngineeringVariable(name: 'BMEP', unit: 'bar');
const _power = EngineeringVariable(name: 'Power', unit: 'kW');
const _engineTemp = EngineeringVariable(name: 'Engine Temperature', unit: '°C');
const _fuelFlow = EngineeringVariable(name: 'Fuel Flow', unit: 'kg/h');

/// All variables the user can choose in the dropdown.
const List<EngineeringVariable> availableVariables = [
  _engineSpeed,
  _torque,
  _bmep,
  _power,
  _engineTemp,
  _fuelFlow,
  EngineeringVariable(name: 'Lambda', unit: '-'),
  EngineeringVariable(name: 'Intake Pressure', unit: 'kPa'),
];

/// Creates a NEW list every time, because the screen changes the items.
List<VariableMapping> createMockMappings() {
  return [
    VariableMapping(tag: 'SPDIG', variable: _engineSpeed),
    VariableMapping(tag: 'TORQ', variable: _torque),
    VariableMapping(tag: 'BMEP', variable: _bmep),
    VariableMapping(tag: 'PWR', variable: _power),
    VariableMapping(tag: 'T_ENG', variable: _engineTemp),
    VariableMapping(tag: 'FUEL', variable: _fuelFlow),
    VariableMapping(tag: 'UNKNOWN'), // not mapped
  ];
}
