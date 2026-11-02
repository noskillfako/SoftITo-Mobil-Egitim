//asset modelleri tanımlamak için açılan dosya
class Asset{
 final String symbol ;
 final String name;
 final double price;
final double change24h;
final double balance;
//require olarak belirtilen değerler girilmesi zorunlu değerlerdir
const Asset({
  required this.symbol,
  required this.name,
  required this.price,
  required this.change24h,
  required this.balance,
});
}