import 'dart:convert';

List<Certificate> certificateFromJson(String str) => List<Certificate>.from(json.decode(str).map((x) => Certificate.fromJson(x)));

String certificateToJson(List<Certificate> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Certificate {
    final String id;
    final String fullName;
    final String dni;
    final String area;
    final String course;
    final int mark;
    final String company;
    final String modality;
    final String duration;
    final String certification;
    final int validity;
    final String date;
    final String status;

    Certificate({
        required this.id,
        required this.fullName,
        required this.dni,
        required this.area,
        required this.course,
        required this.mark,
        required this.company,
        required this.modality,
        required this.duration,
        required this.certification,
        required this.validity,
        required this.date,
        required this.status,
    });

    factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
        id: json["id"],
        fullName: json["fullName"],
        dni: json["dni"],
        area: json["area"],
        course: json["course"],
        mark: json["mark"],
        company: json["company"],
        modality: json["modality"],
        duration: json["duration"],
        certification: json["certification"],
        validity: json["validity"],
        date: json["date"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "dni": dni,
        "area": area,
        "course": course,
        "mark": mark,
        "company": company,
        "modality": modality,
        "duration": duration,
        "certification": certification,
        "validity": validity,
        "date": date,
        "status": status,
    };
}