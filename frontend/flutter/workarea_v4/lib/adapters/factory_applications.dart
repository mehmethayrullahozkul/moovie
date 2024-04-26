/*

  Örneğin uygulamada bir servis kullanıyoruz ve servis classının aynı anda tek objesi olması gerek.
  Mesela aynı anda 2 adet authentication servisi çalışmayacak uygulamamızda.
  // kullanıcı ya giriş yapmıştır ya da yapmamıştır

  // birinde giriş yapmış diğerinde giriş yapmamış olabilir olduğundan tek obje üzerinden çalışacağımız zaman singleton düzeni kullanabiliriz.

*/

class BlablaClassi {
  late String username;
  static BlablaClassi _instance = BlablaClassi._internalPrivateConstructor();

  BlablaClassi._internalPrivateConstructor() {
    username = "bir kez daha degismeyecek";
  }

  factory BlablaClassi() {
    return _instance;
  }
}
