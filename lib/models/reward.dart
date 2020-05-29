import 'package:parent_app/models/teacher.dart';

class Reward {
  int _id;
  double _reward;
  String _achievement;
  Teacher _teacher;

  get id => _id;
  get reward => _reward;
  get achievement => _achievement;
  get teacher => _teacher;

  Reward(this._id, this._reward, this._achievement, this._teacher);

  setId(int id) {
    this._id = id;
  }

  setReward(double reward) {
    this._reward = reward;
  }

  setAchievement(String achievement) {
    this._achievement = achievement;
  }

  setTeacher(Teacher teacher) {
    this._teacher = teacher;
  }

  factory Reward.fromMap(Map<String, dynamic> value) {
    Reward reward = Reward(
        value['id'], 
        value['reward'], 
        value['achievement'], 
        value['teacher']);
    return reward;
  }
}
