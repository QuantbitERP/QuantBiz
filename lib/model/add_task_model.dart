class AddTaskModel {
  String? name;
  String? subject;
  String? project;
  String? priority;
  String? parentTask;
  String? status;
  String? description;
  String? expEndDate;
  double? expectedTime;
  double? actualTime;
  List<AssignedTo>? assignedTo;
  AssignedTo? assignedBy;
  AssignedTo? completedBy;
  String? completedOn;
  double? progress;
  String? issue;
  String? projectName;
  List<Comments>? comments;
  int? numComments;

  AddTaskModel(
      {this.name,
        this.subject,
        this.project,
        this.priority,
        this.parentTask,
        this.status,
        this.description,
        this.expEndDate,
        this.expectedTime,
        this.actualTime,
        this.assignedTo,
        this.assignedBy,
        this.completedBy,
        this.completedOn,
        this.progress,
        this.issue,
        this.projectName,
        this.comments,
        this.numComments});

  AddTaskModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    subject = json['subject'];
    project = json['project'];
    priority = json['priority'];
    parentTask = json['parent_task'];
    status = json['status'];
    description = json['description'];
    expEndDate = json['exp_end_date'];
    expectedTime = json['expected_time'];
    actualTime = json['actual_time'];
    if (json['assigned_to'] != null) {
      assignedTo = <AssignedTo>[];
      json['assigned_to'].forEach((v) {
        assignedTo!.add(AssignedTo.fromJson(v));
      });
    }
    assignedBy = json['assigned_by'] != null
        ? AssignedTo.fromJson(json['assigned_by'])
        : null;
    completedBy = json['completed_by'] != null
        ? AssignedTo.fromJson(json['completed_by'])
        : null;
    completedOn = json['completed_on'];
    progress = json['progress'];
    issue = json['issue'];
    projectName = json['project_name'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
    numComments = json['num_comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['subject'] = subject;
    data['project'] = project;
    data['priority'] = priority;
    data['parent_task'] = parentTask;
    data['status'] = status;
    data['description'] = description;
    data['exp_end_date'] = expEndDate;
    data['expected_time'] = expectedTime;
    data['actual_time'] = actualTime;
    if (assignedTo != null) {
      data['assigned_to'] = assignedTo!.map((v) => v.toJson()).toList();
    }
    if (assignedBy != null) {
      data['assigned_by'] = assignedBy!.toJson();
    }
    if (completedBy != null) {
      data['completed_by'] = completedBy!.toJson();
    }
    data['completed_on'] = completedOn;
    data['progress'] = progress;
    data['issue'] = issue;
    data['project_name'] = projectName;
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    data['num_comments'] = numComments;
    return data;
  }
}

class AssignedTo {
  String? name;
  String? user;
  String? fullName;
  String? userImage;

  AssignedTo({this.name, this.user, this.fullName, this.userImage});

  AssignedTo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    user = json['user'];
    fullName = json['full_name'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['user'] = user;
    data['full_name'] = fullName;
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
