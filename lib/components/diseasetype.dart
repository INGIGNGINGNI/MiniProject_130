class ListDisType {
  String? value;
  String? name;

  ListDisType(this.value, this.name);

  static List<ListDisType> getListDisType() {
    return [
      ListDisType('ไม่ได้เลือก', ''),
      ListDisType('ใบ', 'ใบ'),
      ListDisType('ราก', 'ราก'),
    ];
  }
}
