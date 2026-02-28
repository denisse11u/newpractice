// To parse this JSON data, do
//
//     final viewFlowsResponse = viewFlowsResponseFromJson(jsonString);

import 'dart:convert';

List<ViewFlowsResponse> viewFlowsResponseFromJson(String str) => List<ViewFlowsResponse>.from(json.decode(str).map((x) => ViewFlowsResponse.fromJson(x)));

String viewFlowsResponseToJson(List<ViewFlowsResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ViewFlowsResponse {
    final String? signingFlowId;
    final String? signingFlowBaseId;
    final int? stageId;
    final Stage? stage;
    final Type? type;
    final int? typeId;
    final String? name;
    final List<FileElement>? files;
    final Settings? settings;
    final List<Tracking>? trackings;
    final List<Involved>? involveds;
    final DateTime? expiration;
    final dynamic rejectReason;
    final DateTime? createdAt;
    final CreatedBy? createdBy;
    final bool? addCertificateAtComplete;

    ViewFlowsResponse({
        this.signingFlowId,
        this.signingFlowBaseId,
        this.stageId,
        this.stage,
        this.type,
        this.typeId,
        this.name,
        this.files,
        this.settings,
        this.trackings,
        this.involveds,
        this.expiration,
        this.rejectReason,
        this.createdAt,
        this.createdBy,
        this.addCertificateAtComplete,
    });

    factory ViewFlowsResponse.fromJson(Map<String, dynamic> json) => ViewFlowsResponse(
        signingFlowId: json["signingFlowId"],
        signingFlowBaseId: json["signingFlowBaseId"],
        stageId: json["stageId"],
        stage: json["stage"] == null ? null : Stage.fromJson(json["stage"]),
        type: json["type"] == null ? null : Type.fromJson(json["type"]),
        typeId: json["typeId"],
        name: json["name"],
        files: json["files"] == null ? [] : List<FileElement>.from(json["files"]!.map((x) => FileElement.fromJson(x))),
        settings: json["settings"] == null ? null : Settings.fromJson(json["settings"]),
        trackings: json["trackings"] == null ? [] : List<Tracking>.from(json["trackings"]!.map((x) => Tracking.fromJson(x))),
        involveds: json["involveds"] == null ? [] : List<Involved>.from(json["involveds"]!.map((x) => Involved.fromJson(x))),
        expiration: json["expiration"] == null ? null : DateTime.parse(json["expiration"]),
        rejectReason: json["rejectReason"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        createdBy: json["createdBy"] == null ? null : CreatedBy.fromJson(json["createdBy"]),
        addCertificateAtComplete: json["addCertificateAtComplete"],
    );

    Map<String, dynamic> toJson() => {
        "signingFlowId": signingFlowId,
        "signingFlowBaseId": signingFlowBaseId,
        "stageId": stageId,
        "stage": stage?.toJson(),
        "type": type?.toJson(),
        "typeId": typeId,
        "name": name,
        "files": files == null ? [] : List<dynamic>.from(files!.map((x) => x.toJson())),
        "settings": settings?.toJson(),
        "trackings": trackings == null ? [] : List<dynamic>.from(trackings!.map((x) => x.toJson())),
        "involveds": involveds == null ? [] : List<dynamic>.from(involveds!.map((x) => x.toJson())),
        "expiration": expiration?.toIso8601String(),
        "rejectReason": rejectReason,
        "createdAt": createdAt?.toIso8601String(),
        "createdBy": createdBy?.toJson(),
        "addCertificateAtComplete": addCertificateAtComplete,
    };
}

class CreatedBy {
    final String? userId;
    final dynamic workAreaId;
    final int? typeId;
    final int? statusId;
    final String? identification;
    final int? identificationTypeId;
    final String? emailAddress;
    final String? firstName;
    final String? lastName;
    final bool? mfaEnabled;
    final int? mfaTypeId;
    final bool? mfaAuthenticated;
    final dynamic phoneNumber;
    final List<dynamic>? scopes;
    final List<dynamic>? userTypesAllowedToAssign;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    CreatedBy({
        this.userId,
        this.workAreaId,
        this.typeId,
        this.statusId,
        this.identification,
        this.identificationTypeId,
        this.emailAddress,
        this.firstName,
        this.lastName,
        this.mfaEnabled,
        this.mfaTypeId,
        this.mfaAuthenticated,
        this.phoneNumber,
        this.scopes,
        this.userTypesAllowedToAssign,
        this.createdAt,
        this.updatedAt,
    });

    factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        userId: json["userId"],
        workAreaId: json["workAreaId"],
        typeId: json["typeId"],
        statusId: json["statusId"],
        identification: json["identification"],
        identificationTypeId: json["identificationTypeId"],
        emailAddress: json["emailAddress"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        mfaEnabled: json["mfaEnabled"],
        mfaTypeId: json["mfaTypeId"],
        mfaAuthenticated: json["mfaAuthenticated"],
        phoneNumber: json["phoneNumber"],
        scopes: json["scopes"] == null ? [] : List<dynamic>.from(json["scopes"]!.map((x) => x)),
        userTypesAllowedToAssign: json["userTypesAllowedToAssign"] == null ? [] : List<dynamic>.from(json["userTypesAllowedToAssign"]!.map((x) => x)),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "workAreaId": workAreaId,
        "typeId": typeId,
        "statusId": statusId,
        "identification": identification,
        "identificationTypeId": identificationTypeId,
        "emailAddress": emailAddress,
        "firstName": firstName,
        "lastName": lastName,
        "mfaEnabled": mfaEnabled,
        "mfaTypeId": mfaTypeId,
        "mfaAuthenticated": mfaAuthenticated,
        "phoneNumber": phoneNumber,
        "scopes": scopes == null ? [] : List<dynamic>.from(scopes!.map((x) => x)),
        "userTypesAllowedToAssign": userTypesAllowedToAssign == null ? [] : List<dynamic>.from(userTypesAllowedToAssign!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

class FileElement {
    final String? appFileId;
    final String? appFileTrace;
    final String? originalFileId;
    final String? originalFileTrace;

    FileElement({
        this.appFileId,
        this.appFileTrace,
        this.originalFileId,
        this.originalFileTrace,
    });

    factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        appFileId: json["appFileId"],
        appFileTrace: json["appFileTrace"],
        originalFileId: json["originalFileId"],
        originalFileTrace: json["originalFileTrace"],
    );

    Map<String, dynamic> toJson() => {
        "appFileId": appFileId,
        "appFileTrace": appFileTrace,
        "originalFileId": originalFileId,
        "originalFileTrace": originalFileTrace,
    };
}

class Involved {
    final String? involvedId;
    final CreatedBy? user;
    final Action? action;
    final int? statusId;
    final int? signatureTypeId;
    final bool? withoutSession;
    final bool? isPermanent;
    final int? orderPosition;
    final List<Graphical>? graphicals;
    final DateTime? createdAt;

    Involved({
        this.involvedId,
        this.user,
        this.action,
        this.statusId,
        this.signatureTypeId,
        this.withoutSession,
        this.isPermanent,
        this.orderPosition,
        this.graphicals,
        this.createdAt,
    });

    factory Involved.fromJson(Map<String, dynamic> json) => Involved(
        involvedId: json["involvedId"],
        user: json["user"] == null ? null : CreatedBy.fromJson(json["user"]),
        action: json["action"] == null ? null : Action.fromJson(json["action"]),
        statusId: json["statusId"],
        signatureTypeId: json["signatureTypeId"],
        withoutSession: json["withoutSession"],
        isPermanent: json["isPermanent"],
        orderPosition: json["orderPosition"],
        graphicals: json["graphicals"] == null ? [] : List<Graphical>.from(json["graphicals"]!.map((x) => Graphical.fromJson(x))),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "involvedId": involvedId,
        "user": user?.toJson(),
        "action": action?.toJson(),
        "statusId": statusId,
        "signatureTypeId": signatureTypeId,
        "withoutSession": withoutSession,
        "isPermanent": isPermanent,
        "orderPosition": orderPosition,
        "graphicals": graphicals == null ? [] : List<dynamic>.from(graphicals!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
    };
}

class Action {
    final int? signingFlowInvolvedActionId;
    final String? name;
    final String? showName;
    final bool? hasApprovalInteractions;

    Action({
        this.signingFlowInvolvedActionId,
        this.name,
        this.showName,
        this.hasApprovalInteractions,
    });

    factory Action.fromJson(Map<String, dynamic> json) => Action(
        signingFlowInvolvedActionId: json["signingFlowInvolvedActionId"],
        name: json["name"]!,
        showName: json["showName"]!,
        hasApprovalInteractions: json["hasApprovalInteractions"],
    );

    Map<String, dynamic> toJson() => {
        "signingFlowInvolvedActionId": signingFlowInvolvedActionId,
        "name": name,
        "showName": showName,
        "hasApprovalInteractions": hasApprovalInteractions,
    };
}


class Graphical {
    final String? appFileId;
    final int? pageNumber;
    final int? porcentPositionX;
    final int? porcentPositionY;
    final DateTime? createdAt;

    Graphical({
        this.appFileId,
        this.pageNumber,
        this.porcentPositionX,
        this.porcentPositionY,
        this.createdAt,
    });

    factory Graphical.fromJson(Map<String, dynamic> json) => Graphical(
        appFileId: json["appFileId"],
        pageNumber: json["pageNumber"],
        porcentPositionX: json["porcentPositionX"],
        porcentPositionY: json["porcentPositionY"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "appFileId": appFileId,
        "pageNumber": pageNumber,
        "porcentPositionX": porcentPositionX,
        "porcentPositionY": porcentPositionY,
        "createdAt": createdAt?.toIso8601String(),
    };
}

class Settings {
    final bool? respectOrder;
    final dynamic reminderFrecuencyTypeId;
    final dynamic reminderNumber;
    final dynamic reminderEnabledAfterFrecuencyTypeId;
    final dynamic reminderEnabledAfterNumber;
    final DateTime? updatedAt;

    Settings({
        this.respectOrder,
        this.reminderFrecuencyTypeId,
        this.reminderNumber,
        this.reminderEnabledAfterFrecuencyTypeId,
        this.reminderEnabledAfterNumber,
        this.updatedAt,
    });

    factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        respectOrder: json["respectOrder"],
        reminderFrecuencyTypeId: json["reminderFrecuencyTypeId"],
        reminderNumber: json["reminderNumber"],
        reminderEnabledAfterFrecuencyTypeId: json["reminderEnabledAfterFrecuencyTypeId"],
        reminderEnabledAfterNumber: json["reminderEnabledAfterNumber"],
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "respectOrder": respectOrder,
        "reminderFrecuencyTypeId": reminderFrecuencyTypeId,
        "reminderNumber": reminderNumber,
        "reminderEnabledAfterFrecuencyTypeId": reminderEnabledAfterFrecuencyTypeId,
        "reminderEnabledAfterNumber": reminderEnabledAfterNumber,
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

class Stage {
    final int? signingFlowStageId;
    final String? name;
    final String? showName;

    Stage({
        this.signingFlowStageId,
        this.name,
        this.showName,
    });

    factory Stage.fromJson(Map<String, dynamic> json) => Stage(
        signingFlowStageId: json["signingFlowStageId"],
        name: json["name"]!,
        showName: json["showName"]!,
    );

    Map<String, dynamic> toJson() => {
        "signingFlowStageId": signingFlowStageId,
        "name": name,
        "showName": showName,
    };
}


class Tracking {
    final int? signingFlowTrackingId;
    final String? involvedId;
    final CreatedBy? user;
    final String? descriptor;
    final dynamic ipAddress;
    final dynamic systemOs;
    final dynamic browser;
    final DateTime? createdAt;

    Tracking({
        this.signingFlowTrackingId,
        this.involvedId,
        this.user,
        this.descriptor,
        this.ipAddress,
        this.systemOs,
        this.browser,
        this.createdAt,
    });

    factory Tracking.fromJson(Map<String, dynamic> json) => Tracking(
        signingFlowTrackingId: json["signingFlowTrackingId"],
        involvedId: json["involvedId"],
        user: json["user"] == null ? null : CreatedBy.fromJson(json["user"]),
        descriptor: json["descriptor"]!,
        ipAddress: json["ipAddress"],
        systemOs: json["systemOs"],
        browser: json["browser"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "signingFlowTrackingId": signingFlowTrackingId,
        "involvedId": involvedId,
        "user": user?.toJson(),
        "descriptor": descriptor,
        "ipAddress": ipAddress,
        "systemOs": systemOs,
        "browser": browser,
        "createdAt": createdAt?.toIso8601String(),
    };
}


class Type {
    final int? signingFlowTypeId;
    final String? name;
    final String? showName;

    Type({
        this.signingFlowTypeId,
        this.name,
        this.showName,
    });

    factory Type.fromJson(Map<String, dynamic> json) => Type(
        signingFlowTypeId: json["signingFlowTypeId"],
        name: json["name"],
        showName: json["showName"],
    );

    Map<String, dynamic> toJson() => {
        "signingFlowTypeId": signingFlowTypeId,
        "name": name,
        "showName": showName,
    };
}
