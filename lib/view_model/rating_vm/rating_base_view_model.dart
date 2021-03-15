import 'package:drFamily_app/screens/share/base_model.dart';

class RatingBaseViewModel extends BaseModel {
  double rating = 3;
  String text = "Average";
  String textHint = "How can we improve our service ?";
  String note = "";
  String other = "";
  List<String> list = List<String>();

  changeRating(value) {
    this.rating = value;
    if (this.rating == 5) {
      initText("Excellent", "What did you like most about our service ?");
    } else if (this.rating == 4) {
      initText("Good", "How can we improve our service ?");
    } else if (this.rating == 3) {
      initText("Average", "How can we improve our service ?");
    } else {
      initText("Poor", "How can we improve our service ?");
    }
    notifyListeners();
  }

  initText(String text, String textHint) {
    this.text = text;
    this.textHint = textHint;
    list.clear();
  }

  addNote(String text) {
    if (list.contains(text)) {
      list.remove(text);
    } else {
      list.add(text);
    }
    notifyListeners();
  }

  rateService() {
    this.note = "";
    for (int i = 0; i < list.length; i++) {
      this.note = this.note + list[i].trim() + ", ";
    }

    if (this.other.isNotEmpty) {
      this.note = this.note + this.other;
    } else {
      if (list.length != 0) {
        this.note = this.note.substring(0, this.note.length - 2);
      }
    }
    print(this.note);
  }
}
