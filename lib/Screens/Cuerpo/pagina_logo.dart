import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class PaginaLogoScreen extends StatefulWidget {
  const PaginaLogoScreen({Key? key}) : super(key: key);

  @override
  State<PaginaLogoScreen> createState() => _PaginaLogoScreenState();
}

class _PaginaLogoScreenState extends State<PaginaLogoScreen> {
  late String _logoUrl = '';
  late List<NewsItem> _newsItems = [];
  late Dio _dio;

  @override
  void initState() {
    super.initState();
    _dio = Dio();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    try {
      final response = await _dio.get('https://www.alphavantage.co/query?function=NEWS_SENTIMENT&tickers=AAPL&apikey=apikey');
      if (response.statusCode == 200) {
        final jsonData = response.data;
        const logoUrl = 'https://cdn-images-1.medium.com/v2/resize:fit:1200/1*hDp55PjhtL_RB3n5D0PwBw.jpeg';
        final List<dynamic> newsList = jsonData['feed'];
        final List<NewsItem> newsItems = newsList.map((news) => NewsItem.fromJson(news)).toList();
        setState(() {
          _logoUrl = logoUrl;
          _newsItems = newsItems;
        });
      }
    } catch (e) {
      print('Error al obtener las noticias: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue, Colors.white],
              ),
            ),
          ),
          Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _logoUrl.isNotEmpty
                ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                      ),
                    ]
                  ),
                    margin: const EdgeInsets.only(top: 100),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                        _logoUrl,
                        width: 200,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                  ),
                )
                : const CircularProgressIndicator(),
            const SizedBox(height: 5),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                    if (_newsItems.isEmpty || index >= _newsItems.length) {
                    return const SizedBox(); // O cualquier otro widget de carga o indicador
                  }
                  final newsItem = _newsItems[index];
                  return Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[200],
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.network(newsItem.bannerImage)),
                      title: Text(newsItem.title),
                      subtitle: Text(newsItem.summary),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

class NewsItem {
  final String title;
  final String url;
  final String timePublished;
  final String summary;
  final String bannerImage; // Agregamos la propiedad bannerImage

  NewsItem({
    required this.title,
    required this.url,
    required this.timePublished,
    required this.summary,
    required this.bannerImage,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      title: json['title'] ?? '',
      url: json['url'] ?? '',
      timePublished: json['time_published'] ?? '',
      summary: json['summary'] ?? '',
      bannerImage: json['banner_image'] ?? '', // Asegúrate de manejar la propiedad banner_image
    );
  }
}
