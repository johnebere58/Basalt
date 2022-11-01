import 'package:basalt/basalt.dart';


class ExchangeWidget extends StatelessWidget {
  final TickersModel model;
  const ExchangeWidget(this.model,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.black.withOpacity(.1),width: .5
          ),
        ),
        color: Colors.white.withOpacity(.1),
        elevation: 5,
        shadowColor: Colors.black.withOpacity(.1),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(fit: FlexFit.tight,child: Text(model.name,style: 18.asTextStyle(true,color: Colors.white),)),
                  5.asWidth,
                  Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                    ),
                    color: Colors.blue,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10,2,10,2),
                      child: Text(model.stock_exchange.acronym,style: 11.asTextStyle(true,color: Colors.white),),
                    ),
                  )
                ],
              ),
              5.asHeight,
              RichText(text: TextSpan(
                  children: [
                    TextSpan(text:model.symbol,style:
                    12.asTextStyle(false,color: Colors.white.withOpacity(.5)),),
                  ]
              )),

            ],
          )
        ),
      ),
    );
  }
}
