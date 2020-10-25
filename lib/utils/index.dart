bool isNull(dynamic val) {
  if (val == '' || val == null || val == 'null') {
    return true;
  }
  return false;
}
