class PriceModel {
  int? jarak;
  int? hargacukur;
  int? hargalebih;
  int? potongan;
  int? hargatotal;

  PriceModel(
      {this.jarak,
      this.hargacukur,
      this.hargalebih,
      this.potongan,
      this.hargatotal});

  PriceModel.fromJson(Map<String, dynamic> json) {
    jarak = json['jarak'];
    hargacukur = json['hargacukur'];
    hargalebih = json['hargalebih'];
    potongan = json['potongan'];
    hargatotal = json['hargatotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jarak'] = this.jarak;
    data['hargacukur'] = this.hargacukur;
    data['hargalebih'] = this.hargalebih;
    data['potongan'] = this.potongan;
    data['hargatotal'] = this.hargatotal;
    return data;
  }

  PriceModel.withError(String errorMessage) {
    errorMessage = errorMessage;
  }
}
