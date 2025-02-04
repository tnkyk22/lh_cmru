class pdf {
  String img;
  String name;
  
  pdf({
    required this.img,
    required this.name
  });
}

List<pdf> pdflist = [
  pdf(
    img: 'assets/images/1.jpg',
    name: 'SCITECH123'
  ),
    pdf(
    img: 'assets/images/2.jpg',
    name: 'SCI123'
  ),
    pdf(
    img: 'assets/images/3.jpg',
    name: 'TECH123'
  ),
    pdf(
    img: 'assets/images/4.jpg',
    name: 'MATH123'
  ),
];