import 'package:adobe_xd/adobe_xd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_expose_2k21/login_screen.dart';
import 'package:news_expose_2k21/register_screen.dart';
import 'package:path/path.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:intl/intl.dart';

const colorChineseBlack = Color(0xff151515);
const colorFulvous = Color(0xffE57608);
const colorPhilippineOrange = Color(0xffFF7000);
const colorPrincetonOrange = Color(0xffF2822A);
const colorWillpowerOrange = Color(0xffFC5700);
const colorChineseSilver = Color(0xffCCCCCC);
const colorKUCrimson = Color(0xffE50913);
const colorEerieBlack = Color(0xff1D1D1D);
const colorElectricGreen = Color(0xff00FF00);
const colorRaisinBlack = Color(0xff262626);
const colorWindsorTan = Color(0xffB15106);

const linearButton = LinearGradient(
  begin: Alignment(0.0, -1.0),
  end: Alignment(0.0, 1.0),
  colors: [
    colorPhilippineOrange,
    colorPrincetonOrange,
  ],
  stops: [0.0, 1.0],
);

const linearAppBar = LinearGradient(
  begin: Alignment(0.0, -1.0),
  end: Alignment(0.0, 1.0),
  colors: [
    colorEerieBlack,
    colorRaisinBlack,
  ],
  stops: [0.0, 1.0],
);

const linearProfile = LinearGradient(
  begin: Alignment(0.0, -1.0),
  end: Alignment(0.0, 1.0),
  colors: [
    colorPhilippineOrange,
    colorWindsorTan,
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
const createLogoUIButton =
    '<svg xmlns="http://www.w3.org/2000/svg"  width="51.574" height="42.95" viewBox="0 0 51.574 42.95"><defs><linearGradient id="linear-gradient" x1="0.5" x2="0.5" y2="1" gradientUnits="objectBoundingBox"><stop offset="0" stop-color="#e57709"/><stop offset="1" stop-color="#ff5400"/></linearGradient><linearGradient id="linear-gradient-2" x1="0.5" x2="0.5" y2="1" gradientUnits="objectBoundingBox"><stop offset="0" stop-color="#ff7000"/><stop offset="1" stop-color="#b15106"/></linearGradient></defs><g id="Group_19" data-name="Group 19" transform="translate(-25 -16.025)"><path id="Exclusion_1" data-name="Exclusion 1" d="M5.882,42.95A50.418,50.418,0,0,0,4.2,19.1a49.085,49.085,0,0,0-2.81-6.968A28.2,28.2,0,0,0,0,9.619C.138,9.578,16.579,4.747,32,0a40.263,40.263,0,0,1,6.92,11.417,36.156,36.156,0,0,1,2.359,10.016,33.7,33.7,0,0,1-.115,7.112,20.076,20.076,0,0,1-.5,2.7l-.033.012c-2.912,1-28.628,9.858-34.742,11.69ZM39.314,26.558h0L9.631,35.62l.362,1.3,29.217-8.7.1-1.667Zm.052-3.177L9.631,32.16l.414,1.429L39.365,25.2V23.381ZM5.155,12.695h0c.013.037,1.3,3.837,2.48,7.861.7,2.381,1.231,4.394,1.583,5.981a11.927,11.927,0,0,1,.462,3.93,14.38,14.38,0,0,0,2.392-.976L8.451,17.122l14.479,9.114L17.565,8.528,15.3,9.44l4.654,12.89-14.8-9.635ZM31.269,3.776,21.185,7.161,27.52,24.738l11.635-3.255-.388-1.823-9.243,2.409-2.585-6.705L35.6,12.89l-.84-1.823-8.6,2.539-2.2-5.338L32.3,5.859Z" transform="translate(35.165 16.025)" fill="url(#linear-gradient)"/><path id="tail2" d="M-641.9,95.154s5.559,3.76,10.407,20.913c1.293-17.186-3.038-24.217-3.038-24.217Z" transform="translate(670.956 -59.485)" fill="url(#linear-gradient-2)"/><path id="tail3" d="M-649.683,114.55a36.272,36.272,0,0,1,7.628,16.861c-8.516-12.434-12.395-13.085-12.395-13.085Z" transform="translate(679.45 -74.796)" fill="url(#linear-gradient-2)"/></g></svg>';
const createDrawerUIButton =
    '<svg xmlns="http://www.w3.org/2000/svg" width="41" height="30" viewBox="0 0 41 30"> <g id="Group_18" data-name="Group 18" transform="translate(-297 -22.5)"> <line id="Line_5" data-name="Line 5" x2="35" transform="translate(300 25.5)" fill="none" stroke="#e87207" stroke-linecap="round" stroke-width="6"/> <line id="Line_5-2" data-name="Line 5" x2="35" transform="translate(300 37.5)" fill="none" stroke="#f16604" stroke-linecap="round" stroke-width="6"/> <line id="Line_5-3" data-name="Line 5" x2="35" transform="translate(300 49.5)" fill="none" stroke="#f56003" stroke-linecap="round" stroke-width="6"/></g></svg>';
const createCreateUpdateUIButton =
    '<svg xmlns="http://www.w3.org/2000/svg" width="246" height="246" viewBox="0 0 246 246"><defs><linearGradient id="linear-gradient" x1="0.5" x2="0.5" y2="1" gradientUnits="objectBoundingBox"><stop offset="0" stop-color="#e57709"/><stop offset="1" stop-color="#ff5400"/></linearGradient></defs><g id="Group_20" data-name="Group 20" transform="translate(-52 -57)"><circle id="Ellipse_12" data-name="Ellipse 12" cx="123" cy="123" r="123" transform="translate(52 57)" fill="url(#linear-gradient)"/><g id="Group_18" data-name="Group 18" transform="translate(-25 -201)"><path id="Path_15" data-name="Path 15" d="M1280.2,383.04l-20.16,33.28,16.32,9.76s14.72,1.76,21.76-8.32,1.44-22.72,0-23.04S1280.2,383.04,1280.2,383.04Z" transform="translate(-1040)" fill="#1d1d1d"/><path id="Path_16" data-name="Path 16" d="M1275.4,384c-.8,2.08-18.08,30.24-18.08,30.24h-60.8s-4.32-1.12-1.6-5.6,45.92-78.4,45.92-78.4,3.52-4.64,6.08,0,27.2,48,27.2,48S1276.2,381.92,1275.4,384Z" transform="translate(-1040)" fill="#1d1d1d"/><path id="Path_17" data-name="Path 17" d="M1221.48,357.36l-12.64,21.28-5.28-3.52s-2.24-1.76,0-4.64,9.28-14.72,9.28-14.72a2.96,2.96,0,0,1,4-.96C1219.24,356.24,1221.48,357.36,1221.48,357.36Z" transform="translate(-1040)" fill="#1d1d1d"/><path id="Path_18" data-name="Path 18" d="M1163.6,375.783h17.8s2.733,1.067,2.667,3.333-3.067,2.267-3.067,2.267h-17.4a2.5,2.5,0,0,1-2.4-2.667A2.857,2.857,0,0,1,1163.6,375.783Z" transform="translate(-1040)" fill="#1d1d1d"/><path id="Path_19" data-name="Path 19" d="M1163.6,375.783h17.8s2.733,1.067,2.667,3.333-3.067,2.267-3.067,2.267h-17.4a2.5,2.5,0,0,1-2.4-2.667A2.857,2.857,0,0,1,1163.6,375.783Z" transform="matrix(0.839, 0.545, -0.545, 0.839, -629.628, -603.586)" fill="#1d1d1d"/><path id="Path_20" data-name="Path 20" d="M1163.6,375.783h17.8s2.733,1.067,2.667,3.333-3.067,2.267-3.067,2.267h-17.4a2.5,2.5,0,0,1-2.4-2.667A2.857,2.857,0,0,1,1163.6,375.783Z" transform="matrix(0.545, 0.839, -0.839, 0.545, -157.521, -863.062)" fill="#1d1d1d"/></g><path id="Path_14" data-name="Path 14" d="M1250.92,418.96s.64-3.36,4.32-1.12,12.96,6.72,12.96,6.72a19.066,19.066,0,0,1,0,6.08c-.48,4.16-1.6,17.44-1.6,17.44s0,5.6-3.84,3.52-11.84-7.68-11.84-7.68-2.24.96-1.6-5.28S1250.92,418.96,1250.92,418.96Z" transform="translate(-1065 -201)" fill="#1d1d1d"/></g></svg>';
const createCameraUIButton =
    '<svg xmlns="http://www.w3.org/2000/svg"  width="30" height="26" viewBox="0 0 30 26"><defs><linearGradient id="linear-gradient" x1="0.5" x2="0.5" y2="1" gradientUnits="objectBoundingBox"><stop offset="0" stop-color="#e57709"/><stop offset="1" stop-color="#ff5400"/></linearGradient></defs><g id="Group_20" data-name="Group 20" transform="translate(-1 -1)"><g id="Group_19" data-name="Group 19"><path id="Path_11" data-name="Path 11" d="M28,8.8H23.7L21,6a3.212,3.212,0,0,0-2.2-1H13.2A3.212,3.212,0,0,0,11,6L8.3,8.8H4a2.946,2.946,0,0,0-3,3V24a2.946,2.946,0,0,0,3,3H28a2.946,2.946,0,0,0,3-3V11.8A3.009,3.009,0,0,0,28,8.8Zm-12,15a6.7,6.7,0,1,1,6.7-6.7A6.7,6.7,0,0,1,16,23.8Z" fill="url(#linear-gradient)"/><circle id="Ellipse_11" data-name="Ellipse 11" cx="4.7" cy="4.7" r="4.7" transform="translate(11.3 12.4)" fill="url(#linear-gradient)"/><path id="Path_12" data-name="Path 12" d="M2,5.6H3.6V7.2a.945.945,0,0,0,1,1,.945.945,0,0,0,1-1V5.6H7.2a.945.945,0,0,0,1-1,.945.945,0,0,0-1-1H5.6V2a.945.945,0,0,0-1-1,.945.945,0,0,0-1,1V3.6H2a.945.945,0,0,0-1,1A.945.945,0,0,0,2,5.6Z" fill="url(#linear-gradient)"/></g></g></svg>';
const createGalleryUIButton =
    '<svg xmlns="http://www.w3.org/2000/svg"  width="979.922" height="979.491" viewBox="0 0 979.922 979.491"><defs><linearGradient id="linear-gradient" x1="0.5" x2="0.5" y2="1" gradientUnits="objectBoundingBox"><stop offset="0" stop-color="#e57709"/><stop offset="1" stop-color="#ff5400"/></linearGradient></defs><g id="_svg_gallery_upload_button" transform="translate(0.05 979.619)"><path id="Path_7" data-name="Path 7" d="M138.1-978.9c-4.1.5-12.1,2-17.8,3.4C56.7-960.2,8.4-905.5,1-840.5c-1.4,12.4-1.4,688.6,0,701C9.3-66.7,67.7-8.8,140.6-1c8,.8,74.6,1,252.9.8l242-.3,4.2-2.3c6.6-3.5,11-7.9,14-14,2.3-4.6,2.8-7,2.8-12.8-.1-12-6.4-21.7-17.4-26.8l-4.6-2.1-247-.5-247-.5-7.6-2.2c-37.6-10.7-64.3-38.9-72-75.8-1.8-8.7-1.9-21-1.9-352.5s.1-343.8,1.9-352.5a95.958,95.958,0,0,1,28.2-51,94.787,94.787,0,0,1,48.4-25.6c8.7-1.8,21.4-1.9,352.5-1.9,331.5,0,343.8.1,352.5,1.9a95.958,95.958,0,0,1,51,28.2c12.4,13,19.7,25.7,24.8,43.9l2.2,7.5.5,246.1.5,246,3,5.9c11,21.5,41.8,20.8,52.6-1.1l2.4-4.9.3-240.5c.2-177.3,0-243.4-.8-251.4-4-37.3-20.2-70.2-47.7-96.6-21.9-21.1-46.1-33.9-77.8-41.2l-10-2.3-349-.1C302.5-979.7,142.2-979.4,138.1-978.9Z" fill="url(#linear-gradient)"/><path id="Path_8" data-name="Path 8" d="M285.5-744c-12.4,3.3-21,8.5-31,18.5C240-711.1,234-696.8,234-676.4c0,27.7,14.7,51.2,39.5,63,10.3,4.9,18.4,6.7,30,6.7,11.9,0,19.9-1.8,31-7.2,14.6-7.1,25-17.7,32.1-32.6,9.6-20,9-42.9-1.4-63-5.6-10.7-19.1-23.9-30.2-29.2a93.954,93.954,0,0,0-15.1-5.7C310.9-746.6,294.5-746.4,285.5-744Z" fill="url(#linear-gradient)"/><path id="Path_9" data-name="Path 9" d="M543.5-557.3c-60.4,78-110.1,142.1-110.4,142.5-.4.5-14-21.7-30.1-49.2-16.2-27.5-29.8-49.8-30.2-49.7-.9.3-233.2,234.8-233.6,235.8-.2.5,85.5.9,191.4.9H522.4l7.6-7.8c18.4-19.2,39.6-30,65.3-33.2,4.5-.5,21.8-1,38.4-1H664v-28.3c.1-31.9,1-44.6,4-56.2,2.5-9.5,9.1-23.8,15-32.6,8.5-12.6,24.6-26.8,38-33.5,2.8-1.4,5-3,5-3.6s-2-8-4.5-16.4c-2.5-8.3-4.5-15.8-4.5-16.6,0-1.4-62.7-191.8-63.4-192.5C653.4-698.9,603.9-635.2,543.5-557.3Z" fill="url(#linear-gradient)"/><path id="Path_10" data-name="Path 10" d="M762.5-420.7c-6.5,2.2-9.9,4.3-13.9,8.7-7.5,8.4-7,2.5-7.6,90.5l-.5,79L661-242l-79.5.5-4.6,2.7a34.092,34.092,0,0,0-13,14.2c-2.3,5.1-2.5,15.5-.3,21.9,2,6,7.9,12.6,14,15.7l4.9,2.5,79.3.3,79.2.2V-27.5l2.8,6C748.9-10.8,758.4-4.7,770-4.7c11.8,0,22.1-6.7,27.2-17.8l2.3-5,.3-78.2.3-78.3,79.2-.2c79.1-.3,79.2-.3,83.2-2.5,5.1-2.7,11.9-9.9,14.1-15,2.6-5.8,2.4-17.6-.3-23.4a33.107,33.107,0,0,0-13.8-14.4c-3.9-1.9-6.7-2-83.2-2.3l-79.2-.2-.3-78.3-.3-78.2-2.6-5.6c-3.2-6.7-8.7-12.5-14.5-15C776.8-421.6,767.6-422.3,762.5-420.7Z" fill="url(#linear-gradient)"/></g></svg>';
const createUploadUIButton =
    '<svg xmlns="http://www.w3.org/2000/svg" width="329.4" height="400" viewBox="0 0 329.4 400"><defs><linearGradient id="linear-gradient" x1="0.5" x2="0.5" y2="1" gradientUnits="objectBoundingBox"><stop offset="0" stop-color="#e57709"/><stop offset="1" stop-color="#ff5400"/></linearGradient></defs><path id="Path_8" data-name="Path 8" d="M185.4,361.9H326.6V220.7h94.1L256,56,91.3,220.7h94.1Zm-94.1,47H420.7V456H91.3Z" transform="translate(-91.3 -56)" fill="url(#linear-gradient)"/></svg>';
const createUnseenUIButton =
    '<svg xmlns="http://www.w3.org/2000/svg" width="27.773" height="18.465" viewBox="0 0 27.773 18.465"><path id="Exclusion_2" data-name="Exclusion 2" d="M13.886,18.465a16.632,16.632,0,0,1-6.935-1.521,13.532,13.532,0,0,1-4.244-3.165A12.971,12.971,0,0,1,0,9.233H0V9.226A13.119,13.119,0,0,1,2.707,4.686,13.532,13.532,0,0,1,6.951,1.521a16.569,16.569,0,0,1,13.871,0,13.533,13.533,0,0,1,4.244,3.165,12.971,12.971,0,0,1,2.707,4.546h0V9.24a13.134,13.134,0,0,1-2.706,4.539,13.533,13.533,0,0,1-4.244,3.165A16.635,16.635,0,0,1,13.886,18.465Zm0-14.487a5.255,5.255,0,1,0,5.254,5.255A5.261,5.261,0,0,0,13.887,3.978Zm0,8.257a3,3,0,1,1,3-3A3.006,3.006,0,0,1,13.886,12.235Z" transform="translate(0)" fill="#ccc"/></svg>';
const createSeenUIButton =
    '<svg xmlns="http://www.w3.org/2000/svg" width="27.773" height="18.465" viewBox="0 0 27.773 18.465"><path id="Exclusion_2" data-name="Exclusion 2" d="M13.886,18.465a16.632,16.632,0,0,1-6.935-1.521,13.532,13.532,0,0,1-4.244-3.165A12.971,12.971,0,0,1,0,9.233H0V9.226A13.119,13.119,0,0,1,2.707,4.686,13.532,13.532,0,0,1,6.951,1.521a16.569,16.569,0,0,1,13.871,0,13.533,13.533,0,0,1,4.244,3.165,12.971,12.971,0,0,1,2.707,4.546h0V9.24a13.134,13.134,0,0,1-2.706,4.539,13.533,13.533,0,0,1-4.244,3.165A16.635,16.635,0,0,1,13.886,18.465Zm0-14.487a5.255,5.255,0,1,0,5.254,5.255A5.261,5.261,0,0,0,13.887,3.978Zm0,8.257a3,3,0,1,1,3-3A3.006,3.006,0,0,1,13.886,12.235Z" transform="translate(0)" fill="#e57608"/></svg>';
const createCommentUIButton =
    '<svg xmlns="http://www.w3.org/2000/svg" width="20.35" height="20.094" viewBox="0 0 20.35 20.094"><path id="comment" d="M0,9a9,9,0,1,1,16.808,4.48l1.09,4.06L14.267,16.3A9,9,0,0,1,0,9Z" transform="translate(1 1)" fill="none" stroke="#ccc" stroke-width="2"/></svg>';

final userId = firebaseAuth.currentUser!.uid;

final firebaseAuth = FirebaseAuth.instance;
final firebaseFirestore = FirebaseFirestore.instance;
final firebaseStorage = FirebaseStorage.instance;

final usersRef = firebaseFirestore.collection('Users');
final updatesRef = firebaseFirestore.collection('Updates');

initMain(final context) {
  final width = MediaQuery.of(context).size.width;
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
            initLogo(),
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

initLogo() => Center(
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

initBackground() => Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('res/images/img_background_1.png'),
          fit: BoxFit.cover,
        ),
      ),
    );

initTitle(final text) => Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.all(20.0),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Calibri',
          fontSize: 30,
          color: colorFulvous,
          fontWeight: FontWeight.w700,
        ),
      ),
    );

initInputDecoration(final hintText) => InputDecoration(
      border: InputBorder.none,
      hintText: hintText,
      hintStyle: const TextStyle(
          color: colorChineseSilver, fontStyle: FontStyle.italic),
      filled: true,
      fillColor: colorChineseBlack.withOpacity(0.75),
      contentPadding: const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: colorFulvous),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: colorKUCrimson),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: colorKUCrimson),
      ),
    );

initLabel(final label) => Text(
      label,
      style: const TextStyle(
        fontFamily: 'Calibri',
        fontSize: 25,
        color: Colors.white,
      ),
    );

initTextButton(final context, final firstText, final lastText, final width) =>
    SizedBox(
      width: width,
      child: GestureDetector(
        onTap: () => lastText.contains('Sign Up')
            ? Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const RegisterScreen()))
            : Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginScreen())),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              firstText,
              style: const TextStyle(
                fontFamily: 'Tahoma',
                fontStyle: FontStyle.italic,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            Text(
              lastText,
              style: const TextStyle(
                fontFamily: 'Tahoma',
                fontStyle: FontStyle.italic,
                fontSize: 15,
                color: colorFulvous,
              ),
            ),
          ],
        ),
      ),
    );

onFocusChange(final formKey) async {
  formKey.currentState.save();
  formKey.currentState.validate();
}

late ProgressDialog buildProgressDialog;

initProgressDialog(final context, final message) async {
  buildProgressDialog =
      ProgressDialog(await context, type: ProgressDialogType.normal);
  buildProgressDialog.style(
      message: message,
      borderRadius: 10.0,
      backgroundColor: colorEerieBlack,
      progressWidget: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(
          colorFulvous,
        ),
      ),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      messageTextStyle: const TextStyle(
          color: Colors.white, fontSize: 19.0, fontWeight: FontWeight.w600));
}

buildFlutterToast(final msg, final color, {final isLong = false}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: colorChineseBlack,
        textColor: color,
        fontSize: 16.0);

initTitle1() => Row(
      children: const <Widget>[
        Text(
          'News',
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontFamily: 'Tahoma',
          ),
        ),
        Text(
          'EXPOSÉ',
          style: TextStyle(
            fontSize: 22,
            color: colorFulvous,
            fontFamily: 'Tahoma',
          ),
        )
      ],
    );

buildCircularProgress() => Container(
      alignment: Alignment.center,
      child: const SizedBox(
        height: 100.0,
        width: 100.0,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(colorPhilippineOrange),
        ),
      ),
    );

extension(final path, [int level = 1]) => context.extension(path, level);

initTitle2(final text, {final size = 15.0, final color = Colors.white, final fontWeight = FontWeight.normal, final fontFamily = 'Tahoma'}) => Text(
  text,
  style: TextStyle(
    fontWeight: fontWeight,
    fontFamily: fontFamily,
    fontSize: size,
    color: color,
  ),
);

class TimeAgo {

  static String getTimeAgo(final updateTimestampFormat) {
    final time = DateFormat('dd-MM-yyyy h:mma').parse(updateTimestampFormat);
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inDays > 8) {
      return updateTimestampFormat;
    } else if ((diff.inDays / 7).floor() >= 1) {
      return '1w';
    } else if (diff.inDays >= 2) {
      return '${diff.inDays}d';
    } else if (diff.inDays >= 1) {
      return 'yesterday';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours}h';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes}m';
    } else {
      return 'Just now';
    }
  }

}

initUpdateTimestamp(final updateTimestamp) {
  final dateToTimestamp = DateTime.fromMillisecondsSinceEpoch(updateTimestamp.millisecondsSinceEpoch);
  final updateTimestampFormat = DateFormat('dd-MM-yyyy h:mma').format(dateToTimestamp);

  return TimeAgo.getTimeAgo(updateTimestampFormat);
}
