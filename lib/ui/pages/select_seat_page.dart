part of 'pages.dart';

class SelectSeatPage extends StatefulWidget {
  final Ticket ticket;

  SelectSeatPage(this.ticket);
  @override
  _SelectSeatPageState createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  List<String> selectedSeat = [];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          context
              .bloc<PageBloc>()
              .add(GoToSelectSchedulePage(widget.ticket.movieDetail));

          return;
        },
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                color: accentColor1,
              ),
              SafeArea(child: Container(color: Colors.white)),
              ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20, left: defaultMargin),
                        padding: EdgeInsets.all(1),
                        child: GestureDetector(
                          onTap: () {
                            context.bloc<PageBloc>().add(GoToSelectSchedulePage(
                                widget.ticket.movieDetail));
                          },
                          child: Icon(
                            Icons.arrow_back,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, right: defaultMargin),
                        child: Row(
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(right: 16),
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Text(
                                  widget.ticket.movieDetail.title,
                                  style: blackTextFont.copyWith(fontSize: 20),
                                  maxLines: 2,
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.clip,
                                )),
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                      image: NetworkImage(imageBaseURL +
                                          'w154' +
                                          widget.ticket.movieDetail.posterPath),
                                      fit: BoxFit.cover)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  //Note: Cinema Screen
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    height: 84,
                    width: 277,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/screen.png"))),
                  ),
                  //note: seat
                  generateSeats(),
                  SizedBox(
                    height: 30,
                  ),
                  FloatingActionButton(
                      elevation: 0,
                      backgroundColor: (selectedSeat.length > 0)
                          ? mainColor
                          : Color(0xFFE4E4E4),
                      child: Icon(
                        Icons.arrow_forward,
                        color: (selectedSeat.length > 0)
                            ? Colors.white
                            : Color(0xFFBEBEBE),
                      ),
                      onPressed: selectedSeat.length > 0
                          ? () {
                              context.bloc<PageBloc>().add(GoToCheckOutPage(
                                  widget.ticket.copyWith(seats: selectedSeat)));
                            }
                          : null),
                  SizedBox(
                    height: 50,
                  )
                ],
              )
            ],
          ),
        ));
  }

  Column generateSeats() {
    List<int> numberOfSeats = [3, 5, 5, 5, 5];
    List<Widget> widgets = [];

    for (int i = 0; i < numberOfSeats.length; i++) {
      widgets.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              numberOfSeats[i],
              (index) => Padding(
                    padding: EdgeInsets.only(
                        bottom: 16,
                        right: (index < numberOfSeats[i] - 1) ? 16 : 0),
                    child: SelectableBox(
                      "${String.fromCharCode(i + 65)}${index + 1}",
                      height: 40,
                      width: 40,
                      textStyle: whiteNumberFont.copyWith(color: Colors.black),
                      isSelected: selectedSeat.contains(
                          "${String.fromCharCode(i + 65)}${index + 1}"),
                      onTap: () {
                        String seatNumber =
                            "${String.fromCharCode(i + 65)}${index + 1}";
                        setState(() {
                          if (selectedSeat.contains(seatNumber)) {
                            selectedSeat.remove(seatNumber);
                          } else {
                            selectedSeat.add(seatNumber);
                          }
                        });
                      },
                      isEnabled: index != 0,
                    ),
                  ))));
    }

    return Column(
      children: widgets,
    );
  }
}
