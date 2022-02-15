//BaseUrl

const String baseUrl = "https://tmba.padc.com.mm";
const String moviePosterBaseUrl = "http://image.tmdb.org/t/p/w400";

//EndPoint
const String registerWithEmailEndPoint = "/api/v1/register";
const String loginWithEmailEndPoint = "/api/v1/email-login";
const String getNowShowingMovieEndPoint = "/api/v1/movies";
const String getMovieDetailsEndPoint = "/api/v1/movies";
const String getCinemasListEndPoint = "/api/v1/cinemas";
const String getCinemaDayTimeSlotEndPoint = "/api/v1/cinema-day-timeslots";
const String getMovieSeatEndPoint = "/api/v1/seat-plan";
const String getSnackListEndPoint = "/api/v1/snacks";
const String getPaymentMethodListEndPoint = "/api/v1/payment-methods";
const String getCartListEndPoint = "/api/v1/card";

//Body in api
const String nameParam = "name";
const String emailParam = "email";
const String phoneParam = "phone";
const String passwordParam = "password";
const String googleAccessTokenParam = "google-access-token";
const String facebookAccessTokenParam = "facebook-access-token";
const String accept = "Accept";
const String applicationJson = "application/json";

const String cardNumber = "card_number";
const String cardHolder = "card_holder";
const String expirationDate = "expiration_date";
const String cvc = "cvc";

//Param Key

const String statusKey = "status";
const String date = "date";
const String cinemaDayTimeSlotId = "cinema_day_timeslot_id";
const String bookingDate = "booking_date";

//Param Value

const String statusValue1 = "current";
const String statusValue2 = "comingsoon";
const String authorization = "Authorization";
const String dateValue = "2022-01-27";
const int cinemaDayTimeSlotsIdValue = 1;
const String bookingDateValue = "2-7-2022";

//for test

const String tokenTest = "Bearer 4412|eSoj7MFeu08DeutTSBqBl4dbv1r1es2BIJh2nf7c";
const String dateTest = "2022-01-31";
const String cardNumberTest = "1234.5678.9101.1121";
const String cardHolderTest = "testci";
const String expirationDateTest = "9/22";
const String cvcTest = "123";
