class CommentList {
  String? comment;
  String? commentBy;
  String? creation;
  String? commentEmail;
  String? userImage;
  String? commented;

  CommentList(
      {this.comment,
        this.commentBy,
        this.creation,
        this.commentEmail,
        this.userImage,
        this.commented});

  CommentList.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    commentBy = json['comment_by'];
    creation = json['creation'];
    commentEmail = json['comment_email'];
    userImage = json['user_image'];
    commented = json['commented'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment'] = this.comment;
    data['comment_by'] = this.commentBy;
    data['creation'] = this.creation;
    data['comment_email'] = this.commentEmail;
    data['user_image'] = this.userImage;
    data['commented'] = this.commented;
    return data;
  }
}
