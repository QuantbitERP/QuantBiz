class Ticket {
  int? name;
  String? owner;
  DateTime? creation;
  DateTime? modified;
  String? modifiedBy;
  String? subject;
  String? raisedBy;
  String? status;
  String? priority;
  String? ticketType;
  String? agentGroup;
  String? template;
  String? sla;
  DateTime? responseBy;
  String? agreementStatus;
  DateTime? resolutionBy;
  DateTime? serviceLevelAgreementCreation;
  DateTime? firstRespondedOn;
  String? openingDate;
  String? openingTime;
  String? contact;
  String? customer;
  String? emailAccount;
  int? viaCustomerPortal;
  double? feedbackRating;
  String? feedbackText;
  String? feedback;
  String? feedbackExtra;

  Ticket({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.subject,
    this.raisedBy,
    this.status,
    this.priority,
    this.ticketType,
    this.agentGroup,
    this.template,
    this.sla,
    this.responseBy,
    this.agreementStatus,
    this.resolutionBy,
    this.serviceLevelAgreementCreation,
    this.firstRespondedOn,
    this.openingDate,
    this.openingTime,
    this.contact,
    this.customer,
    this.emailAccount,
    this.viaCustomerPortal,
    this.feedbackRating,
    this.feedbackText,
    this.feedback,
    this.feedbackExtra,
  });

  // Factory method to create a Ticket from JSON
  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      name: json['name'] as int?,
      owner: json['owner'] as String?,
      creation: json['creation'] != null ? DateTime.tryParse(json['creation']) : null,
      modified: json['modified'] != null ? DateTime.tryParse(json['modified']) : null,
      modifiedBy: json['modified_by'] as String?,
      subject: json['subject'] as String?,
      raisedBy: json['raised_by'] as String?,
      status: json['status'] as String?,
      priority: json['priority'] as String?,
      ticketType: json['ticket_type'] as String?,
      agentGroup: json['agent_group'] as String?,
      template: json['template'] as String?,
      sla: json['sla'] as String?,
      responseBy: json['response_by'] != null ? DateTime.tryParse(json['response_by']) : null,
      agreementStatus: json['agreement_status'] as String?,
      resolutionBy: json['resolution_by'] != null ? DateTime.tryParse(json['resolution_by']) : null,
      serviceLevelAgreementCreation: json['service_level_agreement_creation'] != null
          ? DateTime.tryParse(json['service_level_agreement_creation'])
          : null,
      firstRespondedOn: json['first_responded_on'] != null ? DateTime.tryParse(json['first_responded_on']) : null,
      openingDate: json['opening_date'] as String?,
      openingTime: json['opening_time'] as String?,
      contact: json['contact'] as String?,
      customer: json['customer'] as String?,
      emailAccount: json['email_account'] as String?,
      viaCustomerPortal: json['via_customer_portal'] as int?,
      feedbackRating: (json['feedback_rating'] as num?)?.toDouble(),
      feedbackText: json['feedback_text'] as String?,
      feedback: json['feedback'] as String?,
      feedbackExtra: json['feedback_extra'] as String?,
    );
  }

  // Method to convert Ticket to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'owner': owner,
      'creation': creation?.toIso8601String(),
      'modified': modified?.toIso8601String(),
      'modified_by': modifiedBy,
      'subject': subject,
      'raised_by': raisedBy,
      'status': status,
      'priority': priority,
      'ticket_type': ticketType,
      'agent_group': agentGroup,
      'template': template,
      'sla': sla,
      'response_by': responseBy?.toIso8601String(),
      'agreement_status': agreementStatus,
      'resolution_by': resolutionBy?.toIso8601String(),
      'service_level_agreement_creation': serviceLevelAgreementCreation?.toIso8601String(),
      'first_responded_on': firstRespondedOn?.toIso8601String(),
      'opening_date': openingDate,
      'opening_time': openingTime,
      'contact': contact,
      'customer': customer,
      'email_account': emailAccount,
      'via_customer_portal': viaCustomerPortal,
      'feedback_rating': feedbackRating,
      'feedback_text': feedbackText,
      'feedback': feedback,
      'feedback_extra': feedbackExtra,
    };
  }
}
