class NavigationState {
  final bool? _unknown;
  final bool? _isAdding;

  String? selectedTaskId;

  bool get isAdding => _isAdding == true;

  bool get isChanging => selectedTaskId != null;

  bool get isRoot => !isAdding && !isChanging && !isUnknown;

  bool get isUnknown => _unknown == true;

  NavigationState.root()
      : _isAdding = false,
        _unknown = false,
        selectedTaskId = null;

  NavigationState.adding()
      : _isAdding = true,
        _unknown = false,
        selectedTaskId = null;

  NavigationState.item(this.selectedTaskId)
      : _isAdding = false,
        _unknown = false;

  NavigationState.unknown()
      : _unknown = true,
        _isAdding = false,
        selectedTaskId = null;
}
