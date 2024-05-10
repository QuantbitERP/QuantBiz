class TaskList {
  String? name;
  String? subject;
  String? project;
  String? priority;
  String? status;
  String? description;
  String? expEndDate;
  List<AssignedTo>? assignedTo;
  AssignedTo? assignedBy;
  double? progress;
  List<Comments>? comments;
  int? numComments;
  String? projectName;

  TaskList(
      {this.name,
        this.subject,
        this.project,
        this.priority,
        this.status,
        this.description,
        this.expEndDate,
        this.assignedTo,
        this.assignedBy,
        this.progress,
        this.comments,
        this.numComments,
        this.projectName});

  TaskList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    subject = json['subject'];
    project = json['project'];
    priority = json['priority'];
    status = json['status'];
    description = json['description'];
    expEndDate = json['exp_end_date'];
    if (json['assigned_to'] != null) {
      assignedTo = <AssignedTo>[];
      json['assigned_to'].forEach((v) {
        assignedTo!.add(AssignedTo.fromJson(v));
      });
    }
    assignedBy = json['assigned_by'] != null
        ? AssignedTo.fromJson(json['assigned_by'])
        : null;
    progress = json['progress'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
    numComments = json['num_comments'];
    projectName = json['project_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['subject'] = subject;
    data['project'] = project;
    data['priority'] = priority;
    data['status'] = status;
    data['description'] = description;
    data['exp_end_date'] = expEndDate;
    if (assignedTo != null) {
      data['assigned_to'] = assignedTo!.map((v) => v.toJson()).toList();
    }
    if (assignedBy != null) {
      data['assigned_by'] = assignedBy!.toJson();
    }
    data['progress'] = progress;
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    data['num_comments'] = numComments;
    data['project_name'] = projectName;
    return data;
  }
}

class AssignedTo {
  String? user;
  String? userImage;

  AssignedTo({this.user, this.userImage});

  AssignedTo.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user'] = user;
    data['user_image'] = userImage;
    return data;
  }
}

class Comments {
  String? comment;
  String? commentBy;
  String? referenceName;
  String? creation;
  String? commentEmail;
  String? commented;
  String? userImage;

  Comments(
      {this.comment,
        this.commentBy,
        this.referenceName,
        this.creation,
        this.commentEmail,
        this.commented,
        this.userImage});

  Comments.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    commentBy = json['comment_by'];
    referenceName = json['reference_name'];
    creation = json['creation'];
    commentEmail = json['comment_email'];
    commented = json['commented'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['comment'] = comment;
    data['comment_by'] = commentBy;
    data['reference_name'] = referenceName;
    data['creation'] = creation;
    data['comment_email'] = commentEmail;
    data['commented'] = commented;
    data['user_image'] = userImage;
    return data;
  }
}
