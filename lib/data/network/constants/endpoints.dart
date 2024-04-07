class Endpoints {
  Endpoints._();
  static const environment =
      String.fromEnvironment('APP_VERSION', defaultValue: 'production') ==
              'production'
          ? 'http://13.125.200.185:3000'
          : 'http://13.125.200.185:3000';
  // : 'http://192.168.31.131:3000';

  static String serverEndpoint = environment;
  static String baseUrl = serverEndpoint + '/api';
  static String fileUploadUrl = serverEndpoint + '/upload';

  // image upload endpoint
  static String uploadImages = fileUploadUrl;
  static String uploadNftImage = fileUploadUrl + '/nft-image';

  // receiveTimeout
  static int receiveTimeout = 40000;
  // connectTimeout
  static int connectionTimeout = 40000;

  // wallet
  static String getSpendingWallet =
      baseUrl + '/users/wallets/get-spending-wallet';
  static String transferToMainWallet = baseUrl + '/users/wallets/transfer';

  // art
  static String submitArt = baseUrl + '/arts/add-item';
  static String startExhibit = baseUrl + '/arts/start-exhibit';
  static String endExhibit = baseUrl + '/arts/end-exhibit';
  static String getArtList = baseUrl + '/arts/get-list';
  static String getArtItem = baseUrl + '/arts/get-item';
  static String getSubscribedArtList =
      baseUrl + '/arts/get-list-from-subscribed-galleries';
  static String likeArt = baseUrl + '/arts/like';
  static String unlikeArt = baseUrl + '/arts/unlike';
  static String submitComment = baseUrl + '/arts/comment';
  static String removeComment = baseUrl + '/arts/remove-comment';
  static String deleteArt = baseUrl + '/arts/remove-item';
  static String getLikedArtList = baseUrl + '/arts/get-liked-list';

  // gallery
  static String getGalleryList = baseUrl + '/gallery/get-list';
  static String getGalleryListWithMints =
      baseUrl + '/gallery/get-list-with-mints';
  static String getGalleryItem = baseUrl + '/gallery/get-item';
  static String subscribeToGallery = baseUrl + '/gallery/subscribe';
  static String unsubscribeFromGallery = baseUrl + '/gallery/unsubscribe';
  static String updateGalleryInfo = baseUrl + '/gallery/update-gallery-info';
  static String findGalleryById = baseUrl + '/gallery';
  static String getSubscribedGalleryList =
      baseUrl + '/gallery/get-subscribed-list';
  static String addGalleryView = baseUrl + '/gallery/add-gallery-view';

  //gallerist
  static String checkGalleristActivation =
      baseUrl + '/gallerist/check-activation';
  static String activateGallerist = baseUrl + '/gallerist/activate';
  static String deactivateGallerist = baseUrl + '/gallerist/deactivate';
}
