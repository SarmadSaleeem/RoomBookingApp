class Room{

  final String id;
  final String name;
  final int capacity;
  final String location;
  final String? pictureUrl;

    Room(
    {
      required this.id,
      required this.name,
      required this.capacity,
      required this.location,
      this.pictureUrl,
    });


    factory Room.fromJson(Map<String, dynamic> json)
    {
      final id = json['id'];
      final name = json['name'];
      final capacity = json['capacity'];
      final location = json['location'];
      final pictureUrl = json['image'];

      return Room(
          id: id ?? "",
          name: name ?? "",
          capacity: capacity ?? "",
          location: location ?? "",
          pictureUrl: pictureUrl ?? ""
      );

    }

}