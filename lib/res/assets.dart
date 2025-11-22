class Assets {
  static const icons = Icons();
  static const logo = Logo();
}

class Icons {
  const Icons();

  // SVG icons
  final String verified = 'assets/icons/verified.svg';
  final String empty = 'assets/icons/empty.svg';
  final String success = 'assets/icons/success.svg';
  final String reject = 'assets/icons/reject.svg';
  final String myGrambix = 'assets/icons/activity.svg';
  final String library = 'assets/icons/Frame.svg';
  final String home = 'assets/icons/home-2.svg';
  final String profile = 'assets/icons/vuesax.svg';
  final String music = 'assets/icons/music.svg';
  final String search = 'assets/icons/search-normal.svg';
  final String glass = 'assets/icons/glass.svg';
  final String headphone = 'assets/icons/headphone.svg';
  final String backWard = 'assets/icons/backward.svg';
  final String download = 'assets/icons/load.svg';
  final String delete = 'assets/icons/delete.svg';
  final String load = 'assets/icons/load.svg';
  final String grow = 'assets/icons/Going up-rafiki 1.svg';
  final String subscription = 'assets/icons/crown.svg';
  final String editProfile = 'assets/icons/editp.svg';
  final String terms = 'assets/icons/Footer Icon.svg';
  final String policy = 'assets/icons/Footer Icon (1).svg';
  final String supports = 'assets/icons/image 459 (traced).svg';
  final String logout = 'assets/icons/logout.svg';
  final String faq = 'assets/icons/message-question.svg';
  final String changeP = 'assets/icons/Shield Done.svg';
  final String userRemove = 'assets/icons/user-remove.svg';

  // PNG or static image icon
  final String support = 'assets/icons/ss.png';
  final String pay = 'assets/icons/pay.png';


  List<String> get values => [
    verified,
    support,
    empty,
    success,
    myGrambix,
    library,
    home,
    profile,
    music,
    search,
    headphone,
    glass,
    backWard,
    download,
    load,
    grow,
    subscription,
    editProfile,
    userRemove,
    changeP,
    faq,
    logout,
    supports,
    policy,
    support,
    terms,
    pay
  ];
}

class Logo {
  const Logo();

  final String appLogo = 'assets/logo/LOGO BLACK (1).svg';
  final String dummy = 'assets/logo/image 1 (1).png';
  final String cardIMG = 'assets/logo/image 1.png';
  final String banner = 'assets/logo/Rectangle 2.png';
  final String emtyLibrary = 'assets/logo/emty_library.svg';
  final String emptyGrambix = 'assets/logo/grambixEmty.svg';
  final String bg = 'assets/logo/Rectangle 5078.png';

  List<String> get values => [
    appLogo,
    dummy,
    cardIMG,
    banner,
    emtyLibrary,
    emptyGrambix,
  ];
}
