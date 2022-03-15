import 'package:omahdilit/model/modelhair.dart';

class ListModelRambut {
  List<ModelHair>? modelCowok;
  List<ModelHair>? modelCewek;

  ListModelRambut({this.modelCowok, this.modelCewek});

  ListModelRambut.fromJson(Map<String, dynamic> json) {
    if (json['model_cowok'] != null) {
      modelCowok = <ModelHair>[];
      json['model_cowok'].forEach((v) {
        modelCowok!.add(new ModelHair.fromJson(v));
      });
    }
    if (json['model_cewek'] != null) {
      modelCewek = <ModelHair>[];
      json['model_cewek'].forEach((v) {
        modelCewek!.add(new ModelHair.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.modelCowok != null) {
      data['model_cowok'] = this.modelCowok!.map((v) => v.toJson()).toList();
    }
    if (this.modelCewek != null) {
      data['model_cewek'] = this.modelCewek!.map((v) => v.toJson()).toList();
    }
    return data;
  }
    ListModelRambut.withError(String errorMessage) {
    errorMessage = errorMessage;
  }
}