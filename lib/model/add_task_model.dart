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
  List<String>? assignedTo; // List of email strings
  double? progress;
  String? issue;
  String? projectName;
  List<Comments>? comments; // List of Comments objects
  int? numComments; // Added numComments field

  AddTaskModel({
    this.name,
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
    this.progress,
    this.issue,
    this.projectName,
    this.comments, // Added comments field
    this.numComments, // Initialize numComments
  });

  AddTaskModel.fromJson(Map<String, dynamic> json) {
    name= json["name"];
    subject = json['subject'];
    project = json['project'];
    priority = json['priority'];
    parentTask = json['parent_task'];
    status = json['status'];
    description = json['description'];
    expEndDate = json['exp_end_date'];
    expectedTime = json['expected_time'];
    actualTime = json['actual_time'];
    // assignedTo = json['assigned_to'] != null
    //     ? List<String>.from(json['assigned_to'])
    //     : null; // Parse list of strings
    progress = json['progress'];
    issue = json['issue'];
    projectName = json['project_name'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
    numComments = json['num_comments']; // Parse numComments
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
      data['assigned_to'] = assignedTo; // Serialize list of strings
    }
    data['progress'] = progress;
    data['issue'] = issue;
    data['project_name'] = projectName;
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList(); // Serialize comments
    }
    data['num_comments'] = numComments; // Serialize numComments
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

  Comments({
    this.comment,
    this.commentBy,
    this.referenceName,
    this.creation,
    this.commentEmail,
    this.commented,
    this.userImage,
  });

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

class Project {
  final String name;
  final String projectName;

  Project({
    required this.name,
    required this.projectName,
  });

  // Factory constructor to create an instance of Project from JSON
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      name: json['name'] as String,
      projectName: json['project_name'] as String,
    );
  }

  // Method to convert a Project instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'project_name': projectName,
    };
  }

  @override
  String toString() {
    return 'Project{name: $name, projectName: $projectName}';
  }
}

