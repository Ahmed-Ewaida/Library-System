

class User{
  final String name;
  final String universty_code;
  final String level;
  final int phone_number;


  User({
    required this.name,
    required this.universty_code,
    required this.level,
    required this.phone_number,

  });
}
class Community{
  final String post;
  final String like;
  final String dislike;
  final String comment;

  Community({
    required this.post,
    required this.like,
    required this.dislike,
    required this.comment,
});
}
