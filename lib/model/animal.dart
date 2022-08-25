class Animal{
  String id_dacdiem;
  String name_dacdiem;
  Animal({required this.name_dacdiem,required this.id_dacdiem});
  Map<String,dynamic> toJson()=>{
    'id_dacdiem':id_dacdiem,
    'name_dacdiem':name_dacdiem
  };
  static Animal fromJson(Map<String,dynamic> json) => Animal(name_dacdiem: json['name_dacdiem'], id_dacdiem: json['id_dacdiem']);
}