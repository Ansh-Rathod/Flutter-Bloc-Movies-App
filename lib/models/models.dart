class TrendingList {
  final List catergory2;
  final List company;
  final List catergory1;
  final List catergory3;
  final List catergory4;
  final List catergory5;
  final List catergory6;
  final List catergory7;
  final List marvel;
  TrendingList({
    this.catergory2,
    this.company,
    this.catergory1,
    this.catergory3,
    this.catergory4,
    this.catergory5,
    this.catergory6,
    this.catergory7,
    this.marvel,
  });
  factory TrendingList.fromDocument(doc) {
    return TrendingList(
      catergory2: doc.data()['Catergory2'],
      catergory4: doc.data()['Catergory3'],
      catergory5: doc.data()['Catergory4'],
      catergory6: doc.data()['Catergory5'],
      catergory7: doc.data()['Catergory6'],
      company: doc.data()['Companys'],
      catergory1: doc.data()['Catergory1'],
      catergory3: doc.data()['Catergory'],
      marvel: doc.data()['Marvel'],
    );
  }
}
