class ListPlantType {
  String? value;
  String? name;

  ListPlantType(this.value, this.name);

  static List<ListPlantType> getListPlantType() {
    return [
      ListPlantType('ไม้ยืนต้น', 'ไม้ยืนต้น'),
      ListPlantType('ไม้เลื้อย', 'ไม้เลื้อย'),
    ];
  }
}
