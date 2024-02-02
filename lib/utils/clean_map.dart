Map<String, dynamic> cleanMap(Map<String, dynamic> map) {
  map.removeWhere((key, value) {
    if (value == null || value == '') return true;
    if (value is Map) {
      cleanMap(value as Map<String, dynamic>);
    }
    return false;
  });
  return map;
}
