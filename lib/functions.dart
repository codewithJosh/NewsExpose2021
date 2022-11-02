import 'package:adobe_xd/adobe_xd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const colorChineseBlack = Color(0xff151515);
const colorFulvous = Color(0xffE57608);
const colorPhilippineOrange = Color(0xffFF7000);
const colorPrincetonOrange = Color(0xffF2822A);
const colorWillpowerOrange = Color(0xffFC5700);

const linearButton = LinearGradient(
  begin: Alignment(0.0, -1.0),
  end: Alignment(0.0, 1.0),
  colors: [
    colorPhilippineOrange,
    colorPrincetonOrange,
  ],
  stops: [0.0, 1.0],
);

const createChineseBlackDecoration =
    '<svg viewBox="44.0 -54.0 272.0 329.0" ><path transform="translate(-386.0, -54.0)" d="M 430.0415344238281 202.4214477539063 L 430.0002136230469 202.4214477539063 L 430.0002136230469 199.1912841796875 L 430.0002136230469 0 L 702 0 L 702 202.4214477539063 L 701.9586791992188 202.4214477539063 C 700.160888671875 272.6188659667969 639.9781494140625 328.9996948242188 566.0001220703125 328.9996948242188 C 492.0211791992188 328.9996948242188 431.8392944335938 272.6188659667969 430.0415344238281 202.4214477539063 Z" fill="#151515" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const createChineseBlackDecoration1 =
    '<svg viewBox="0.0 336.0 360.0 847.0" ><path transform="translate(-644.0, 313.0)" d="M 644.0004272460938 870.0000610351563 L 644.0004272460938 81.43687438964844 C 698.087646484375 44.09025573730469 759.4588012695313 23.00040245056152 824.4999389648438 23.00040245056152 C 889.14208984375 23.00040245056152 950.1563720703125 43.83037567138672 1004.000427246094 80.74948120117188 L 1004.000427246094 870.0000610351563 L 644.0004272460938 870.0000610351563 Z" fill="#3c3c3c" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const createLine =
    '<svg viewBox="22.5 327.5 1.0 91.0" ><path transform="translate(22.5, 327.5)" d="M 0 0 L 0 91" fill="none" stroke="#ffffff" stroke-width="5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const createLogo =
    '<svg viewBox="111.2 35.0 137.6 115.9" ><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#ffe57709"  /><stop offset="1.0" stop-color="#ffff5400"  /></linearGradient></defs><path transform="translate(138.33, 35.0)" d="M 15.69064998626709 115.9499206542969 C 20.32205009460449 89.23610687255859 15.80901050567627 66.19276428222656 11.20749187469482 51.56584930419922 C 8.602261543273926 43.2846565246582 5.693727493286133 36.76549530029297 3.712469577789307 32.75484085083008 C 1.563138008117676 28.40383720397949 0.01543441228568554 25.99120712280273 0 25.96734809875488 C 0.3682273924350739 25.85771179199219 44.22358322143555 12.81397533416748 85.35112762451172 0 C 93.38047790527344 9.537745475769043 99.59098815917969 19.90725135803223 103.8110504150391 30.82075691223145 C 107.1872329711914 39.55185317993164 109.3042144775391 48.64895248413086 110.1032638549805 57.85937118530273 C 110.8141860961914 66.05392456054688 110.3283157348633 72.82278442382813 109.7955169677734 77.05815887451172 C 109.2177581787109 81.65169525146484 108.4632186889648 84.33293151855469 108.455680847168 84.35948181152344 L 108.3665771484375 84.39095306396484 C 100.5983123779297 87.10034942626953 31.99993324279785 111.0044403076172 15.69064998626709 115.9499053955078 L 15.69064998626709 115.9499206542969 Z M 104.8694686889648 71.69686889648438 L 104.8694229125977 71.69688415527344 L 25.69147682189941 96.16078186035156 L 26.65670967102051 99.67622375488281 L 104.593132019043 76.19612884521484 L 104.8694686889648 71.69688415527344 L 104.8694686889648 71.69686889648438 Z M 105.0075302124023 63.11991500854492 L 25.69152069091797 86.81986999511719 L 26.7948112487793 90.67771148681641 L 105.0074844360352 68.04149627685547 L 105.0074844360352 63.11992645263672 L 105.0075302124023 63.11991500854492 Z M 13.75080490112305 34.27140426635742 L 13.75084972381592 34.27146148681641 C 13.78458976745605 34.37199020385742 17.21663856506348 44.62934112548828 20.36750030517578 55.49290084838867 C 22.23201370239258 61.92133712768555 23.65238380432129 67.3538818359375 24.58908271789551 71.63961791992188 C 25.76003265380859 76.99674224853516 26.17429542541504 80.56665802001953 25.82024574279785 82.25022125244141 C 30.75014877319336 80.51783752441406 32.18599700927734 79.62310028076172 32.19990539550781 79.6142578125 L 22.54429244995117 46.22223663330078 L 61.16805648803711 70.82694244384766 L 46.85618209838867 23.02293395996094 L 40.8219108581543 25.4841136932373 L 53.2365608215332 60.28229522705078 L 13.75084972381592 34.27144622802734 L 13.75080490112305 34.27140426635742 Z M 83.4105224609375 10.19348049163818 L 56.51251602172852 19.33274459838867 L 73.41046142578125 66.78482055664063 L 104.447265625 57.99747848510742 L 103.4121780395508 53.07590866088867 L 78.75507354736328 59.57922744750977 L 71.85867309570313 41.47704315185547 L 94.96327209472656 34.79816436767578 L 92.7215576171875 29.87738418579102 L 69.78933715820313 36.73183441162109 L 63.92641830444336 22.32064247131348 L 86.16973876953125 15.81733894348145 L 83.4105224609375 10.19348049163818 Z" fill="url(#gradient)" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#ffff7000"  /><stop offset="1.0" stop-color="#ffb15106"  /></linearGradient></defs><path transform="translate(763.93, -12.74)" d="M -641.9000244140625 100.7692260742188 C -641.9000244140625 100.7692260742188 -627.0713500976563 110.918701171875 -614.1393432617188 157.2284088134766 C -610.6907958984375 110.8308258056641 -622.243408203125 91.85000610351563 -622.243408203125 91.85000610351563 L -641.9000244140625 100.7692260742188 Z" fill="url(#gradient)" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#ffff7000"  /><stop offset="1.0" stop-color="#ffb15106"  /></linearGradient></defs><path transform="translate(765.66, -15.49)" d="M -641.7335205078125 114.5499877929688 C -641.7335205078125 114.5499877929688 -625.8702392578125 132.4763336181641 -621.38720703125 160.0688323974609 C -644.1043701171875 126.5008850097656 -654.449951171875 124.7433929443359 -654.449951171875 124.7433929443359 L -641.7335205078125 114.5499877929688 Z" fill="url(#gradient)" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';

createStart(final BuildContext mContext) {
  final width = MediaQuery.of(mContext).size.width;
  return Stack(
    children: <Widget>[
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('res/images/img_background.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Pinned.fromPins(
        Pin(start: 0.0, end: 0.0),
        Pin(size: 329.0, start: -29.0),
        child: Stack(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 44.0),
              width: width,
              child: BlendMask(
                blendMode: BlendMode.overlay,
                child: SvgPicture.string(
                  createChineseBlackDecoration,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            createSvgLogo(),
          ],
        ),
      ),
      Pinned.fromPins(
        Pin(start: 0.0, end: 0.0),
        Pin(size: 847.0, end: -423.0),
        child: Stack(
          children: <Widget>[
            SizedBox(
              width: width,
              child: BlendMask(
                blendMode: BlendMode.overlay,
                child: SvgPicture.string(
                  createChineseBlackDecoration1,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Pinned.fromPins(
              Pin(start: 0.0, end: 0.0),
              Pin(size: 110.0, start: 60.0),
              child: Container(
                margin: const EdgeInsets.only(left: 22.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SvgPicture.string(
                      createLine,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(
                      width: 9.5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          'YOUR DAILY',
                          style: TextStyle(
                            fontFamily: 'Tahoma',
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'NEWS UPDATE',
                          style: TextStyle(
                            fontSize: 40,
                            color: colorFulvous,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Center createSvgLogo() => Center(
      child: SizedBox(
        height: 170.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SvgPicture.string(
              createLogo,
              allowDrawingOutsideViewBox: true,
            ),
            const Text(
              'NEWS EXPOSÉ',
              style: TextStyle(
                fontFamily: 'Tahoma',
                fontSize: 15,
                color: colorWillpowerOrange,
                letterSpacing: 6,
              ),
            ),
          ],
        ),
      ),
    );
