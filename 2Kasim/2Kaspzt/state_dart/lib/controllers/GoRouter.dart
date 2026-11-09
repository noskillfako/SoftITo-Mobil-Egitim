import 'package:go_router/go_router.dart';
import 'package:state_dart/widgets/anakasa.dart';
import 'package:state_dart/widgets/vitrinekran.dart';
import 'package:state_dart/widgets/profilekrani.dart';
import 'package:state_dart/widgets/anasayfa.dart';


final GoRouter uygulamaRotalari=GoRouter(
  initialLocation:'/vitrin',
  routes:[
    ShellRoute(
      builder:(context, state,child) {
        return AnaKasaEkrani(ekranGovdesi:child);
      },
      routes:[
        GoRoute(
            path:'/anasayfa',
            builder:(context,state)=>const AnaSayfaEkrani(),
        ),
        GoRoute(
          path:'/vitrin',
          builder:(context,state)=>const VitrinEkrani(),
        ),
        GoRoute(
          path:'/profil',
          builder:(context,state)=>const ProfilEkrani(),
        ),
      ],
    ),
  ],
);